Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0A0DCC6B1D
	for <u-boot@archiver.kernel.org>; Wed, 14 Oct 2026 14:49:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5579760829;
	Wed, 14 Oct 2026 14:49:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kx8CDBn1AOKs; Wed, 14 Oct 2026 14:49:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org A751F607C3
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791989348;
	b=pwUkliim9IJUr8+QbcxMQkcqRYoTQs+cQixDsasysLoHWGrjDQyxT0Eu3XXnrDHVpv+T
	 zx61ikGeDjHzorWQdHDk/9wQbXt3E1VSD8blFDpmc6qaf3nb105vfd4IcwiDYLOdElWcc
	 dP7aYYX7Hm+fIZTPdZlrfL0ANjKOpFfN5hLwfnoWrMCW6YGvaF/CWdaa9jOF9R2S/f0GH
	 ScwadFa52VhPzjCIVBfJvnJlpCQzJ0nVmqxB7fD77SL/fHB/lDV6RJJPwjUsEpNrHDhXH
	 g+aQDwOJifV20lHuSH14XXErTq/h2Mf3hLWVmGbbldmyDNF+uM1Yf2a4HDyyiaaSv/w==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791989348;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=Ir1+ZKjEYVGXUtxWJpv1qIvMr6dAbooNMbJz++69nds=;
	b=ODqXht43yBW0wblYCjjPYussHUpTvqe6/sq8qVZSG+64RHm5UppWQpBKI++LDJNscZng
	 WbAEYNp3Q7F+rF6RndWgmlJ57A5xx9SX4Yqa/rndU3KGuqG3+evvPzCzPgkER8PFulJ33
	 Oks2TXmjSQNzrWgZzNFCLyeoUPq/au74TASMcJ+HbpIsAnwKj1aZRtesYxq5ni2lrThuM
	 A/6bqiMMkL3aYe+8WLlNC+zpTsgw3jUQew3GW5ExcpybjiBSYJv3dnt+n8rsm90yVA93v
	 QKBvu9s0RvFRqU1xHKhc9vcDdzp3BJv2XPGkKMaBgwZ5Qm1Hq/BMbaG4s7EBedqg+9g==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791989348;
	bh=Ir1+ZKjEYVGXUtxWJpv1qIvMr6dAbooNMbJz++69nds=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=WRLBCI9jJHjSjR5NIEFmlARfUPHiEuispzgQcBpk8A5hSXSTZG4y+tnpnWP7vSj1F
	 RSWZSXbe6doc4gWI1kTYmVWzambgi8jan2NWk7oTXg+oKtX1EkIKRT2+CKRxvjCm3c
	 gZmYCYVsAkQzZb/uv1R+y5bpcPk2xgOZ0FqGXvAX/ndL6WnGMoWhqrLf6f+N5QnZty
	 SQgH+FLKgjSatid9FcWKcv6LM6CYKToCc7ojRtTGA8cWxeOW+mU175ge9OyFCpv+E4
	 LJ7dnxL9d75lHqZyXQsVbiR5+odqedR6/LHm4SwAOuBbv74IYLLEPISflRl9EWwnl3
	 cFxDO5Oro4lPQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id A751F607C3;
	Wed, 14 Oct 2026 14:49:08 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 8CC69E4D
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 14:49:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8A86940752
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 14:49:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id y77MY3Mh5w0f for <u-boot@lists.u-boot-project.org>;
 Wed, 14 Oct 2026 14:49:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org B09D240753
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::432"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791989347;
 b=X+BYSNQFqg9Fb28NTuq3dqfUvjUhLBnaNH6KNvJ1nDEmsqGrrL8KLX6/U2130kPRB0vD
 VXl79IPr2Bqyu3IUP4WEEaV/jn4SZzpxGrj4N7HzG7Q96mGtA7kHY0hNPcmUU/r2fHj6H
 sAQ10O0Wk2KQS+UfSSZFFJAOD/cZ6Ng9xG11lyx2/TIMvs0eiOv6t+lfhBgtal1rR0qd0
 TSXBbNDG89sJo2wYk/ohTyz12aRRuK5bh3V9kfS8s8hYOif5FtwVIfYwT6LTWHOSZHaCJ
 +yM35w92gRWPrkoA9cnlSKN5Yks4M/wDwLA48BznbkyeKHQlu5NOJ0Imm1UNa+69n4A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791989347;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
 bh=Ir1+ZKjEYVGXUtxWJpv1qIvMr6dAbooNMbJz++69nds=;
 b=nyfNIeNkvN/UOw+YJzgMXZwe8RwJdPeLFD/jEcI0Yjiql41nA60xN3nJbUQkGJUxDBtj
 U0KW31Wn5/LRTDGn/Kxyoxur9L+cwRhc4OshoWPC1HaJjjAAvTW14ySnYZaotNjQYXD/7
 TRYEoo77LBQkrpBC92xsDABOvEmCY7rGCdivHFMNTL1g59zT2i5DDB0lDSjmfk0VrUKbF
 aYxytJXqHtHo+2N9NniKueYkjOstYSBQ3d8Ogfq6MlTq2EUaGlbK6TZgJYj92l2OsXvNd
 kiN2N3DDhA47Ovj59SMABJtWspk/HLrHQqhfLKyNd/jC0tSUobmHYE5GGU8GrrVsCLA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=WIAxNeJ3; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::432"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::432; helo=mail-wr1-x432.google.com;
 envelope-from=bmeng.cn@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=WIAxNeJ3
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B09D240753
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 14:49:04 +0000 (UTC)
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-48afcfc4bf5so535616f8f.1
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 07:49:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791989343; cv=none;
 d=google.com; s=arc-20260327;
 b=lV9POnKfHDyO/xkgSK88GXM741RrnDRzBcFKNTEBvNmRjqfWg8i6DoTwBgPKHA3dwi
 srEk65PJ9UZdovRDWCvmIaVCLaMY6rWjeTyP788fttUDHiFHv6iFsBcguFyJ8WjYauHw
 SqCaB9R6To7wTRPJ9UI4B+ububjQaCYQKGq7UmCTfW4IsDFefhHq644URJ9+2Qbbc6bZ
 rwQufWavbEJ3GCrAXn5XcW89dTRwvvMSyY6HgybPhvknJ1GMUeviWK9b6WJOtQFiG4ez
 ePURSJApaW8JrNfADo2qo5iqBRhDHjbgwQ9mhVHIzSRx3heKUGSXFXMEWYwMKll5ysc5
 Zo2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Ir1+ZKjEYVGXUtxWJpv1qIvMr6dAbooNMbJz++69nds=;
 fh=e5oQ1SoCAUtJOITuFi4BxPz5XcPVxOlut0ME0QpcLUY=;
 b=piy5lpXITG/6rAONxEpjMxHh/bLOy4lV0XaEC9iAjmN4GRP5WVqNAQV9XkLEfQ+RR+
 MSBN8nsFJ/r4MhckZIFlx2tjlKSjz90cr6bjE6EKs24sVAcPw+BqEbbGnQcTSiPH9/AN
 n+3J/YT6Grt6jD57AuiwL99iY/idSn0/Cu74JJpfqwvwld76groitUtHw7F4tAh/qDUB
 Ln0JkbU0c+g8oIrzkbqWAKc5COlJ4NxGSASBeiKDV0O5F8Yoq83I3Rx9OgXxYz0awHaa
 tVbF4pMmA6GVg4ClGHeQVVFGNiDmptwzlKkme9saf4SClECfu8C80x1zp3fdA/rtyW0k
 44bA==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791989343; x=1792594143;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Ir1+ZKjEYVGXUtxWJpv1qIvMr6dAbooNMbJz++69nds=;
 b=WIAxNeJ3YWmx69DOXxj5hXGz0ynFRveWwf/vWtm38rCMsbA2Q6OfSvwPYDLuoIxWfw
 isF5BPF8jnneK14UCFJeGyBVNygnM9cVkHSjB7tZcjVt/ttMncu9yGrr882Pd1o9FdlL
 +fIP5znc/yANfC9ZYm82Ht0KQKiF1xdFH0Q3c0QjE5IUq6n2SdqZneIonDlAsi6CWC2C
 qe6ml7j07sF8nw4JL58tbrOxx6MP856n5BFmbjyxbySMn1sxetUeeOJpNdh1crUVwy80
 1nqFat0WaOHzMWruxUGtqeWaWI6EE9fBYig2UIP07TWm7hW5uP7f9+T+okJv1jpTBOPh
 pScA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791989343; x=1792594143;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Ir1+ZKjEYVGXUtxWJpv1qIvMr6dAbooNMbJz++69nds=;
 b=duQQl2fgAkKqBKdQr+X4TqmL5imol65oskaTPiOUMUzzOCXoclbWjojURcbxXjuMrz
 IBLb/FzaqJbg146TRs2ayBYEeCvYebpYs4v+F8n/knez5dSQWbs/EIy+U0qmy9oM5hH9
 mvIhgUJzp9xklW+LvcmZvlugnHkyzYS+JcCNGl6hXIEyy/Llkq1YtITO0lfPwLySo439
 PSxXkEejCPSllds2z+72ZepoCqvDj1WzExcb4qg++E91GCbmKyFUArErAxzTqv/VL01x
 Kg35RJjwK8DPwunF7V/sZtnBq972HspCgCd8wlr24xRiNLQJ+7YHJOeo6WRWKMTyPL+A
 K/Qg==
X-Forwarded-Encrypted: i=1;
 AKwUvBz3hpiCicwUG/kC5Z+71iauyhESAw+Y+uaCFDWb3ji4dV9dKanOf0MqHeaRKVu1gXIDNNkO0xc=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYLhWocGHvv7BBGOwFL+OM4WVdhbQQ9ifUhZC3/3bt0PlVRHQos+
 cU2FlqpxJ/42/lJKpNR6IJTtuGvDCDyXZLJO/Fx9j4U4Mf9EhSdHJwUbO1OZOytK8mfX43XkIDY
 oGmrfc9AQhsUA2v1nr4JJ2ZtdWRk/vek=
X-Gm-Gg: AYBFou2NBB+T7huenimvVRsy43AndXywWny20C+YPSP7hao/5e7Gv4/Z5DJjObFfyKL
 EG57O15ypa6cHAUyAXQVRMmXKyMZWOKUsz9B2Lym+nQCZPB8t3PCPpTPPoWA5SSYaKbwwf72emc
 rfWriDxVdACcfiLWptA78Ea9w+IeQ7gPlyoUAo0q13MU/iGRUeRe/5hf//d4SHWc7/2MA+QtJY5
 EfjDRknTFzzfkY3idrabKa0j+jNkXgCbODXXOm61y8nb0ZqgjMXODYe7UUKUsfqJrsOjA4lPP5Q
 KOAGgfu9mwHu5hyhQQrn+psDs0mxpiV+XeksE+kW7YXYKy+9mca4J4TUlo2cGqdEgcLIJxBheCJ
 IdL+S3oID0Y7XXdiC
X-Received: by 2002:a05:6000:29c3:b0:488:764c:7a17 with SMTP id
 ffacd0b85a97d-48dba788922mr21647478f8f.1.1791989342462; Wed, 14 Oct 2026
 07:49:02 -0700 (PDT)
MIME-Version: 1.0
References: <20261014140716.1181882-1-alan.tseng.cs@gmail.com>
 <20261014140716.1181882-4-alan.tseng.cs@gmail.com>
In-Reply-To: <20261014140716.1181882-4-alan.tseng.cs@gmail.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Wed, 14 Oct 2026 22:48:45 +0800
X-Gm-Features: AclHuK86Co9y7bxUyzPz0bcHb-60m7JfcAb5O_6Ph7R_jcFnZtrSZUznrH4AQ-U
Message-ID: <CAEUhbmU47BXmqTSH08ECv_bU6mamFMd8T7VD6ENTYSbTYsNrKw@mail.gmail.com>
Subject: Re: [PATCH 3/3] MAINTAINERS: Add entry for virtio RTC
To: Hung-Chun Tseng <alan.tseng.cs@gmail.com>
Cc: Tom Rini <trini@konsulko.com>, Kuan-Wei Chiu <visitorckw@gmail.com>, 
 Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 u-boot@lists.u-boot-project.org
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

On Wed, Oct 14, 2026 at 10:07=E2=80=AFPM Hung-Chun Tseng
<alan.tseng.cs@gmail.com> wrote:
>
> Add myself as the maintainer of the virtio RTC driver.
>
> Signed-off-by: Hung-Chun Tseng <alan.tseng.cs@gmail.com>
> ---
>  MAINTAINERS | 5 +++++
>  1 file changed, 5 insertions(+)
>

Reviewed-by: Bin Meng <bin.meng@processmission.com>
