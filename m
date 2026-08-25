Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F38D8C5DF81
	for <u-boot@archiver.kernel.org>; Tue, 25 Aug 2026 01:25:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 946C180C9A;
	Tue, 25 Aug 2026 01:25:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jhrkd6P3do1a; Tue, 25 Aug 2026 01:25:01 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787621100;
	bh=uzFLY/DpqhslXUW21rfOJT8iipsQ4+0SKSD6PjWcNck=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=TNpp7Qwms3D1SrhFUJktFqtX0mvJhaJigsC+hX0MnZmdFVjOwO+/nNpK3fqIftHog
	 GT4oq/IrAT1yyo8QR32hzMOIwK10GxtOSK4pFtM3LXVGka1LVzPh0lBJlbuu0OJ5jl
	 tMhuvTUXy1tz7C0dy9XzkxUym2WYBUGJtLKMq29TVfSuchLRpv718kwXE2R5e5tZNh
	 /mZvwcoOB3NP/f9L3xZm8aOPlncYIkfs/TeMdyrQ6ENBfyS/8dN5zA6z0/3/gYfOhC
	 JiKFjqN9KUHSVsdxZu+CaG4Ty1EFVf33kEv5FdeAHeD12OsfzVdipXtP0NCV3Zbvmp
	 mWHSHKpQzFLWA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id CB65C80BCF;
	Tue, 25 Aug 2026 01:25:00 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id A021B3DA
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 01:24:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8601540557
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 01:24:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7zfKffQHJkMh for <u-boot@lists.u-boot-project.org>;
 Tue, 25 Aug 2026 01:24:59 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::12a; helo=mail-lf1-x12a.google.com;
 envelope-from=festevam@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=kUhvX0eA
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com
 [IPv6:2a00:1450:4864:20::12a])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 946AA40558
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 01:24:57 +0000 (UTC)
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-5b15dcaca31so4038459e87.0
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 18:24:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787621095; cv=none;
 d=google.com; s=arc-20260327;
 b=oPMlJqJwtZVhK9bhRLjrky2lQl7ZpVNl/x6uWFXnj7EstdbxDSJVCJ9DzmcjxSl1Mw
 yiB9tluV56CHVye6T7KCfBNQzarhuIecS+nfy2PGHpX5vllUFsLjdKvqP+jU1mYRSxiD
 H2Ty3B25PXizZ4eQaru2vshAEMHGVGnpZHRNPrSFCzmuCKIbKKrzs8Q8UAU09YJ8Buyo
 joKIdEGo3A+aDw5AcRAMjpzXDfQcvwcCJ5Ns6iPCeUF51iwwauFYnvTm9+BYp+H7gbuW
 FAmwJEjJTX4K5scaDnXM4dOkY3whWlIHYJfmDe4nEQsOuSAX6TUoCEYr8wwz+WCTDJQR
 FWXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=uzFLY/DpqhslXUW21rfOJT8iipsQ4+0SKSD6PjWcNck=;
 fh=AuQ3bIBeU64EwsP1Al2N/FlN5xzoW+fHpS7uviycxow=;
 b=bPBXmGfTreNVa5GqLbuUYYNy0rfq4hmZPEK5bb5A9BbI8/CjBU+LtgiN++/+877lhw
 oRWLymErPhYB/umgaRH7uJK6Bne4Fy+ltrNS0VJnNQ69fg57IYE9n+0j/UkKh+wXFBIr
 5USM/nKj5Ue3eLjB38TBtDmqJn/JvqWCGxQWOvswvFF+wuNDSEB3Y/33/2gFLpcNqcHY
 DGI4Etk4E+3pQMJP8ghblKZRQ1bumbOuqCHa8vPADhYAWxMw3d9P9E3nN09BFOahOxQC
 OBkBoRAaVlW7pzvWpm/wfn4wy7Bz+dQVwnoL/yS7PtMcem8qq2kuUioTIXDHuaxKckw8
 zmhg==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787621095; x=1788225895;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=uzFLY/DpqhslXUW21rfOJT8iipsQ4+0SKSD6PjWcNck=;
 b=kUhvX0eAXWp6kwzqP/V4gmbTTHZmrp6u81cfXOFsKfQeoTcEeM7LKXR1t/E05iKUV+
 /wCJ3qsLvVra7y0XZCX/o4PMLERuimoEk4yU4w9gscvImtI3DJ/lMLfUMYV6T94RXRFn
 Qk+KYQjkGJvEipPZtzxCu1msBNl7tKj8Fnyxuc3/i9f86j+RFspa9u64jhI4llqkhE6H
 lx+78mpkgpSNZPH7MHfhP/wI2G+Cile3CrTtPBvFMbdF3FZ8L5WeEnRUnUl8Vs9JmCSD
 axLUi8wBTQyYZmBj0+P/JBeFcIa3SgTT7tfDs88RAFtWeq8qWCyH9cpFAJED8nhKizYC
 KVLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787621095; x=1788225895;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=uzFLY/DpqhslXUW21rfOJT8iipsQ4+0SKSD6PjWcNck=;
 b=UAfOpoy0ROSTS5UOyCtolV5ueU6jNnlS70MXcuf3R6eGfpv1xToIv4Cc+A0oqFLjF5
 wWZ/9TlDUsRqoNo/SBrt/v4HjohIkkopyw2SMSdQ5KzguUwid6tx3QNJq6i3KuZmqeCp
 7YoHj5QjlhsXoxQNxeXqhRgd18Dq3Y21shJQ0nVpPcFQ5xPuuoMQtx74NAbPF7GmDmQk
 3TG9y/liy0HRvT8UMsRpCQBKj+D+5rh46KA4IJcbY64Pq9NEuvGRpOVoae8sAAdfNJ16
 b3DNIkcAuKCkxbDZeRv8eMW6WN9Hpkvc5JYEc0PbAypDmCwn5V3pm/EsAlGiB5lgMb79
 pYwg==
X-Forwarded-Encrypted: i=1;
 AHgh+RqkQ+4rg9OJ9pHgm0ocS3YIw48DzBOAFppw52ZCeECc2A15b+wxasFRCmtoSSt5ruoIoceR4BM=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++kE+qIj9XNi9mP7NeF2079isgEck0EGKMcQaPfW1tUvG3ONB7YU
 HQdaW4dlGXa5uze2Sq7G1viUDimwpH1BtIlJ6Ru2EFzJeUSA6bLPi93j6ydL/srkhwgiFfnBVxq
 nVyl+nfJaofcjy/h2+va+0ceziw2k9xQ=
X-Gm-Gg: AR+sD13ApFhEzzMgyleI2SSCpIXyVMu+ZyFcd32SVwYRuK1i4u/JIkgA2rA9CcMkcz5
 FXFJOsFpWz/NPivzM6kYlGvVfwTVANhLWjzB64PCdq372prAgyZkVpYx9ileVKiohm4H2P0cTfk
 ZWaV1Sm4SD4gpvfCjCTgCPH60PtUlJ54pyNyjebtpp9TDogiG0ijVNcmcSQyiji0A6GlanebnRY
 uMrFB5Wf3ZZWbawH/1Mn6vWAuvAH8GyhW1NXAY4l3kMvrEtiVPACy8WgJ5enxFV1YGcWKJgVVEu
 q0MXlMpkg//FpnKI9uImiXWO/QVb1iH8byGzTcK08fZlY1H+WB0vqGTit8V6gf+iewkbbXi4yCH
 eu/VcXdLEd1DKgZNu4RMbXHz0G8Csq0Fl
X-Received: by 2002:ac2:4e0d:0:b0:5ae:bd5e:95f7 with SMTP id
 2adb3069b0e04-5b4842099b7mr9692314e87.4.1787621094586; Mon, 24 Aug 2026
 18:24:54 -0700 (PDT)
MIME-Version: 1.0
References: <20260821070958.6997-1-eichest@gmail.com>
In-Reply-To: <20260821070958.6997-1-eichest@gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 24 Aug 2026 22:24:41 -0300
X-Gm-Features: AcwNN1XmLTzWd1AGeUan03qFSz82JNYM-Zlscri70Udp8vmrVEMPMm-3d-ERa0k
Message-ID: <CAOMZO5AY7nkpdyBckixiBTRLK6f1YTL=H14cLnoMLc+Qh5=MvA@mail.gmail.com>
Subject: Re: [PATCH v1] toradex: {aquila, smarc,
 verdin}-imx95: add board_fix_fdt
To: Stefan Eichenberger <eichest@gmail.com>
Cc: francesco.dolcini@toradex.com, sbabic@nabladev.com, uboot-imx@nxp.com, 
 trini@konsulko.com, franz.schnyder@toradex.com, 
 stefan.eichenberger@toradex.com, emanuele.ghidoli@toradex.com, 
 sjg@chromium.org, u-boot@lists.u-boot-project.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hi Stefan,

On Fri, Aug 21, 2026 at 4:10=E2=80=AFAM Stefan Eichenberger <eichest@gmail.=
com> wrote:

> +#if IS_ENABLED(CONFIG_OF_BOARD_FIXUP)
> +int board_fix_fdt(void *fdt)
> +{
> +       /* Remove nodes based on fuses. */
> +       return imx9_uboot_fixup_by_fuse(fdt);

Shouldn't this be added to the common i.MX95 SoC file instead of
adding it per board?
