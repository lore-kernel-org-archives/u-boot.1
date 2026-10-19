Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33BB3CCF2DE
	for <u-boot@archiver.kernel.org>; Mon, 19 Oct 2026 13:20:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id F343A80DB0;
	Mon, 19 Oct 2026 13:20:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id H2XdMAgvxaGv; Mon, 19 Oct 2026 13:20:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 570DF80DC4
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792416021;
	b=efHYlru68tS200d24siMf98ovB+WIx85fPIqi/GkGyqI5RyRUiPt2zg+oYSD2q579uut
	 1K0Ya4icCBfc+bdlbW7Y39Ipl7Pkbs3l+5Ew0IjTaH7jx6qxpMWQGaeo1I2mQAWSP2Vv5
	 G1AngK3GbVZ01HcV8Bt5fEV3vGfw9qDyTsXOyzQr9pcFOYQE+NXkISEZ2owJvTH5bfx0x
	 2vE3GOxCwS5VbsyMveN5MwZpPPXdawtkPscZ5hDooeSYbuyvbRMSTB/G4SVNAzu7tWv2z
	 hx3nufIVM76NMahL/LN6O7TzFqbiJwWJfW+tgYgQ7r+/P+GNWg9JMMmMuN1iolJMZXQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792416021;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
	 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=MG/Uq+SrSAlSKCJMXjknKgjAyJ6G/8FNZoEKM49TWfw=;
	b=BVRtt3l/OXrxNm4670g+M5MTd8TCICQpPCPyv0KBl8+O3pntGrLwyqLnQ4Fhlz5s0FP+
	 NuH/qdnUuJbgKua5E8UsH0j+PObQpUmeE+AI7Lv9d3E0INEmshTH3tk+jigiDga9ApDgx
	 M2lGnwlMeCiamHtafunrTP0kh6ojUE89ijjUge65SFHwON/Z77kHSug21PxvFk9hfujye
	 3QwlN5Qy6nuFjIPD3Lpl1lcIjPV1TSrm6WaS+iY5/Sw4+9pzjz3MPX+wS13DGFtgzRw93
	 vBQJVgkmAoeCwVGFY8CYEchhml+BSs5SoagP1ARLe8SztBvXT56IihZItbdn6lMYlGg==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	dmarc=pass header.from=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=GkpilOH8;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792416021;
	bh=MG/Uq+SrSAlSKCJMXjknKgjAyJ6G/8FNZoEKM49TWfw=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=N2rsGxamjvp00VvI8UVhNTy3h7kyNSjQQqkd75HjABpTzCkRSVSOZ4hZf8WfABQiM
	 OBK7BFIePdXO86nKubZL9Dh5BFMDtpsr/hDoGu3cviqzzHliEkBEWJb1AGX+r+Rqa7
	 VONVawkkKB38Y+vOu+vItzHRHQFyN7IN7zTpH+4LG48RPznmu1R2t6PAUaG06gvIpv
	 hQ+mQAxowItQULR1IxZHWJQXaWIwGHw4rEnFb6QCCm7nYUWbt1A6DB665OpjeI0sth
	 sFSg5N2LOJqkXEHyLnNcY1ytkiubSOEsVshFBwPG7GrOzKG0H50DFOMm9AMqpaj7wu
	 DXeDzx/k6200w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 570DF80DC4;
	Mon, 19 Oct 2026 13:20:21 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 2539E263
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 13:20:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0ADCC80DC4
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 13:20:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Eujpk1p2BfJG for <u-boot@lists.u-boot-project.org>;
 Mon, 19 Oct 2026 13:20:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 0569880DB0
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::535"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792416019;
 b=bFVA8A4E/ukgOEiCZocUA+V63agqJTGqvpBPd3QVCBKGZ1kaOm+/9xScJza5WVbYFNFB
 GzfboxvlizAnJDKDFsEG2lx9444nnThTv/5P5a4TEpzHJXuOkOdZLvsqwQLbMl2Fe9RQ+
 Rm+mwv6wQzePWLf3hqEK70FSUvw43ap9ULSm85CmpJOsc3HZ/5Aqc/Uv5IxFWqrFx2Bbc
 3fn3OeTfuX7eYLVkwPNknOS+1/wfOlzxiAqQ/3DucevukVWDvGqnMrpLJUraai/n0qmD5
 MMeKqebTr/E3EEuPz+VQx/7pWNe3eMpyQKoMGw/1ZPmzPCvB2TfswSSYrUFmyaMkedA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792416019;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Received:MIME-Version:In-Reply-To:References:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=MG/Uq+SrSAlSKCJMXjknKgjAyJ6G/8FNZoEKM49TWfw=;
 b=CxRr4S9sl2FUpV2EHHYOHhi6rPOeoExAenX6Ku6h1jMn99kSmkP2wIEDDEL4I5Y2K26n
 1SHU3CWpvLEzzeIZYmNadfE9fmzDBBjVDdVoNkEHMVGmuPbZS0OZi1ldQlRVC3wT3nx86
 9P5xSJXCezQkeu9JaCMopS3mBgpzypR6DZTbNYeOvtEMZJPb8D9iVFALIPnG6u71Lzz2o
 FAZ+YyTG8Cw2+6IBbPizkjO9clY/KxrQLuOCYmRTcf9rO044zPrNv/IIHXedupWpk7846
 nI1klg6IxyphNiyJI5HOL9p3UaEKu18iQzl1ToYpZyXpoOQwcDDrCQ1YOJ76D4XEDQg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=GkpilOH8; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::535"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::535; helo=mail-ed1-x535.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=GkpilOH8
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0569880DB0
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 13:20:18 +0000 (UTC)
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-6b1afcd2d23so2490895a12.1
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 06:20:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792416017; cv=none;
 d=google.com; s=arc-20260327;
 b=EXjju0Zb6qYzGzkNrnvRGzMf7FsdaYtDhXgZpLUkzun69xbvCFUw1LUcUOSnWWod47
 DRlZrCD58iRvPeQKWe5GW3TAEWA126w6PJsTqXfbNpCSbEIkJgMWccJfH4ACyVLcf8rl
 sZdanheF2Kmc+ew/KTxIHPCdSurl7ZPPbJl9X2fW0+OEhii4ruidQ7JElRtcDypR7/sd
 dWJPmhzTj9HnS5SFfzP6QTcfPYntUautyZjMtmaJe9QSX3v49Y1xLn8RQNHHcoB0TSjD
 /oxVJHssfhwU5MdUCybiYvMnEj7E/p55Efgtx63Mi9cw7HDY7l5It3MSKqJnT8/8TVwg
 B1Ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=MG/Uq+SrSAlSKCJMXjknKgjAyJ6G/8FNZoEKM49TWfw=;
 fh=rInDknHvAKatoeqB8xcFJuvrlPk6JpdVpRDuTOFt1xQ=;
 b=B2UdL7j68Ff+oMh139i+l5QlQ53bpAwk29wFJhJSGZqAr2NtBKEuH8xEslTbdXTT9d
 IgUsnDu5ToeXhE9i+JOA/XT749hEUs5HOEe2inqiHXibeikNrgaGqSzTXxwBDuQ7AUdZ
 vkaeT38bMjCYobVWIJ3QMZ6W1GF8W/0QB1K99zJOYOjjtucZuRksJYieWuFRQL9ufNKX
 Jr3vD4sAx9JCPGgNf1OjrFvsfordIikrWydlqdUemNS7tMkitmqK9MAe4DLtrjNpiB4f
 9+Q1dWEVTNCqq7oED6F29ZPuC9UPmut2Z6WSBKGjmzn7b1zIHC+4L5K4z/35Pbm84Ojv
 Qd2A==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1792416017; x=1793020817;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=MG/Uq+SrSAlSKCJMXjknKgjAyJ6G/8FNZoEKM49TWfw=;
 b=GkpilOH8am/qw3ldEYwNTGsmHAblTfICjDkNz0jPrEinebW9D66+lC5gkcfL5cB9GK
 pmIG1bg9ymv0yDqPED8iT1DjqbMm9AivuKdfIWDwvVv0N/x5fUfVVg2+FKGECxsYsJgo
 7w4st8SSTCexpFi8JeRFpl7WywXl1Ri6h9ZwQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792416017; x=1793020817;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=MG/Uq+SrSAlSKCJMXjknKgjAyJ6G/8FNZoEKM49TWfw=;
 b=aLXyIpwcScPDa5OLjH3pQB/KDiuNV6n6FFYtYpuYZxr0vKEAxHt9tnv6iIq1e2fXOq
 mxdOrNW+HGI7c1XnNLe4qexmeLZzmquQ0lavm4wiJCmSVBLY0LrKWZKkDSIriGcdi7YS
 XntPxw9N5I/w6IPhFlJxpZn1pcQzbkbYFyRpWWoAnx5EVDpkhkkT5Ies8xF8CQe4BPgB
 DTkUuFvdn26MANusJdyRy8rZa4Y3G8b8FJNWphnJhI4yNgYdSwQgP3aiZsb5sko9k21U
 C7dQ8hPtrw7X7S0OVT0Gyl4zS/EAHIwHQh/6dHcTBep98eQZ9yQt0y+UwnohsuWyqNdj
 P1sQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBx/dy7NlV/M786IaF5bVJvTtDUrai2VRDzXv6RtPc110dDgeNCaC9RXnHWLUTYpKYDQW5EYLjI=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYJSWULWz9R8f0w/LfJT4knU0ku4fweRfQ21h6Dhb2Th8g0dF+xq
 BM0VQSWHGRvZftzbUHtc2Fl6yjEXKO9WpD29xTuUfiGqMz5AgZyA7tNyzadk3IZfgV/y911b04x
 Sea7ifuCY535KhfXwq3rrfd45+r3VWS9IqXN6euPIUxmGRK9ogumf9w==
X-Gm-Gg: AYBFou3CCtBRQg20zAokIQDE9y1Hsy0lkUJEwii8ExMyTQ2ba+kseVRguxvpI2ywsvh
 rsHhTz1/di0/BzF0IxDdNwN7njovpc7oKyaCxii7ou5WVehGDWY9Lg1s0y77DmnSB4JqcHeNTLJ
 DEOU4KLoHtAobVQqmKfngHKug2O0CFqVx0NYGGoUEW2xaXdzeN5Xj64HX/6BmoTAi98Gs9SBZpS
 YLOHYCHdb6FLJQuOqG6k0KEgyL1+DRq9TIoIhaGN66ZT5GMr+1+LxIO7mu8yQNx3H5eiYH+7WUD
 WSQ5EpRX7HLiz22VYgG4Y5aRsnJ5OI2SCNIPM2KL2vUllLMb+QI+ig==
X-Received: by 2002:a05:6402:400e:b0:6b3:c946:61f4 with SMTP id
 4fb4d7f45d1cf-6b3c9466593mr2645438a12.15.1792416016545; Mon, 19 Oct 2026
 06:20:16 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 19 Oct 2026 15:20:13 +0200
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 19 Oct 2026 09:20:06 -0400
MIME-Version: 1.0
In-Reply-To: <20261016065500.137544-4-me@ziyao.cc>
References: <20261016065500.137544-1-me@ziyao.cc>
 <20261016065500.137544-4-me@ziyao.cc>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 19 Oct 2026 15:20:13 +0200
X-Gm-Features: AclHuK_sdxgiEZI7Ru7-UMkUgLoEm5m_v0rT7lghyjNwXAsXjIHmuQvtizw3U1c
Message-ID: <CAFLszTiueG6b1Nvyk9zOp=6tpsS3hgXgqHHj83RT2n6GQMvjhA@mail.gmail.com>
Subject: Re: [PATCH v5 03/20] image: Take entry point as an output of
 setup_booti
To: me@ziyao.cc
Cc: Tom Rini <trini@konsulko.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 u-boot@lists.u-boot-project.org
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Hi Jiaxun,

On 2026-10-16T06:54:41, Yao Zi <me@ziyao.cc> wrote:
> image: Take entry point as an output of setup_booti

The subject still says 'setup_booti' - please change it to booti_setup()

Regards,
Simon
