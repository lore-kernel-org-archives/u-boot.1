Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56A91CCF2C1
	for <u-boot@archiver.kernel.org>; Fri, 16 Oct 2026 21:47:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 122D440AAE;
	Fri, 16 Oct 2026 21:47:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Ft97zfMWePEm; Fri, 16 Oct 2026 21:47:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org EBFD740A7E
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792187234;
	b=YXD56dgl53J8VztL0j8ej0dnSYYUEwFKRKr4GOEXFlD/KEGzb0yfhlrMoQXh8vk+1Bqt
	 ae25k+8G6Dii8safIw+x42uUbLqKxvzspxLhJ4mrpwJlMbo9cFeLXjZhA02hwSr8P9dr8
	 wqwSWsJ1jjLTcxsXh7u8sawvWnywUlsGzHt+UlsPk/G3leIzlpqzKE3t/waTw+PxHQ61X
	 TQ81+zWPPj3GP6Do/CPX5b1f0DOUMOrp4NQ2C2UxkzMOx/iW7uGUXGE7dVYGNTHM83jQH
	 2tla7pVmZF3TawksV/Cm8aYCPTVydnbpxbW1bzZ8MYDiOM7BOAF7F/XN2h26cksxYcg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792187234;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
	 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:Content-Transfer-Encoding:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=bzjpyNu8TDsZHs3OelkLBVEV0pcZ39Ces7ch7uiV7SI=;
	b=TyLlJPPxzeCr540eN/NbUWBvSYUCWT05tat+ODEoaQQZFD06KRDcqYw9xLJLgkfPVPda
	 xrWbrt93IDyQm7ZeuizxwpwhdZe+WHPDuz6CWohJWTh60tzqIaEX0ZToJG2m2XWutQwvJ
	 CT5m1riqDCUGGLtaa1aLQfG3AuHfKV2RifjddNz6R/J/RiqcQzcPs/GHY7FDiBNnq189g
	 5PdMUIqlsOdmD+j/cD7DxSwv4SdH362v4D2QADNYh0delbT65HSGjd4RH5DjlK846EVz3
	 RRGnuo7tSWq/mi7bIwewYBFteGzULygj5GF4pzHr02KLKlZA0dqnBYY71f1tfB7N84Q==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792187234;
	bh=bzjpyNu8TDsZHs3OelkLBVEV0pcZ39Ces7ch7uiV7SI=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Y4ON/2nuaT+nqlOXz0QULU5uRmsF5DFCRLZvf7MMnIPJ7eOUrb5jVRVE8nnFfMyMX
	 47VHOZvah3lpjyCdo7HrTgpQ9VJUQ7WgDP74tj0eYLzbkY7k2uQzuLYT2shtmw4ji8
	 Gkyh6C3Yr0PMGidvq5N7D2x6wULYCIsri3PAxqzcZPqlo1ALtD8lxVfGTCBlsfi2ng
	 htQ9R22zaVnNa3WGWHJIFw3f+tUO741+HlLoohmUpUzSIy4V+/BI3TpfZdlTOHvjEH
	 PDR2rCvAyn6/akj/7s1i77NS6F+MJxt5ds27K3sBV19oV/GJVfPgzpF7S1JLFSdrko
	 nj7tka2Hzs0yA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id EBFD740A7E;
	Fri, 16 Oct 2026 21:47:13 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id A5982105
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 21:47:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 8BAE360A45
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 21:47:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Ale_hf080ru2 for <u-boot@lists.u-boot-project.org>;
 Fri, 16 Oct 2026 21:47:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 536A8607C4
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::52d"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792187230;
 b=bPAp6g3VA+nQTMfoaNRx3mQEUGF6SuvQFIdXgQaUDPCXFLlymcYbmirTUBYPDx1jSlfQ
 HnTgi1fqeVt+dgHGOfbH12eKPwDLrd5KDRtFKPgTAVvMgZ082OHRi1VukguLUv8dCUjjk
 nHUTxIJ+uZhXJ2tlOVi3HmCWpvhiDgcaUukr4GbMT1KsgwgYeaHFIuGZYUZpLd1gfrOeK
 cAauj3HPp6D4/2a119MFSonAyzKGOAe8dNxnTLhkq6nITvg8LH5v9NXJTjcfC8OdLK7qN
 TeDOzk8vApLpcpMRO0vQp3bbTV6cGPkMROo+l0zw0izoGX6cqwgSJGKdyfmEwoUxcPw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792187230;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Received:MIME-Version:In-Reply-To:References:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
 bh=bzjpyNu8TDsZHs3OelkLBVEV0pcZ39Ces7ch7uiV7SI=;
 b=QvHmNEGm0ECMC+pcokqAuqHvr55ND8VZQOoBq/vnQG+2ViQBCoo2pWp8ovElsKKBzRCx
 YV80yTowsYVaQc5IUPt05kTFZEUFonLCjbMbwInb1yEwoTlEvCSsQuiBh6IQ2zh4eZZd0
 QuPSHRA0X22p1C8hfHNmYS++aK4FZZQlSQ2ZjikSoD2WiiWn0xUN7YLHDW8uU1e6pzBs6
 Qq6KvzaXwrfjYIUip7h6wxKlbRgPMKtAQqXHbFHq0axiCtA8AhTE3NRqK4/E5XXBpezgO
 4US6CAm9LY1ayBtiANdIvEE49kpxOkq0BQU9pDU+D9NJJWfPj7mgoSqcpWcN0fLbnLw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=PKkZ3OnR; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::52d"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::52d; helo=mail-ed1-x52d.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=PKkZ3OnR
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 536A8607C4
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 21:47:09 +0000 (UTC)
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-6aa9164072cso390763a12.2
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 14:47:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792187228; cv=none;
 d=google.com; s=arc-20260327;
 b=EwvBDVWBgoWLsbyMbO+6XoSC7C87QyzN57+PQKPlxLS0LL5wH6lIRPZleLUyvWd2fK
 rFjX60y7L3hy/jbxGH7PNdYcpySMg1VBY1nid3D0RDuDvRoP4Fgs8+ZLwGQ3L9+iQFzc
 eFGzPZTxM6lkePIkTOnfScnVw7VaUb0YhP6JxJR56Pi4yiDuTZFqRlBCzG4jX6mEL13V
 swIitG/XcLS+ZX4kd6Ovu2qiE9y9ldaLt4ZxGBfcO2k2rZikH6UIj0JjQgiCIAHLkXS4
 rEK7NjPzvn8D0pFBrCRPBf+gG+xscME6cIU4vueKMhqfpoJh1a73nhiVtCtZjwqMZD/o
 +Sqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :references:in-reply-to:mime-version:dkim-signature;
 bh=bzjpyNu8TDsZHs3OelkLBVEV0pcZ39Ces7ch7uiV7SI=;
 fh=hiiU+5DqFKrkw/V9ELZklqGihCW2+1rcF8RAbTGbsew=;
 b=E8pNVbNAIVdxAi9zwtLwU5QjqSdWdIb3YpgCAMamtxZ4GULvIn46H7D2wdWGeLQXah
 307YiLgutTaBKEvpW9uIJuuM+KdkIBpKYKM082dFjVQ5C3ovUWxNd3UnUrv+W6n4MOo3
 p842O3hnzIF/dS4V17A9jqhRHgh86gAhWzzx2CLZ+tKA3yx5R69HLhXj1PKM2K9KGM1s
 D71rfdZaLqiqio358ZdzfirpVrqLRpqmwTqjGnsdRNXqAEDwiTbWekBVp0gn2RrcfZHK
 GEx0QGutFaD4TkqwD4LXEm8eGmLBNcZIwsNlux7xeJL8zxV9DyRuTyrmQ2aWVsqsSdj7
 HDmQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1792187228; x=1792792028;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:references:in-reply-to:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=bzjpyNu8TDsZHs3OelkLBVEV0pcZ39Ces7ch7uiV7SI=;
 b=PKkZ3OnRaSHweUbNaccq5CQ9uX8+VoJHdLjvXhfjEzsiJb9nLM+EneRppYd2PldNFk
 XutvxHQccdZwbfw4agaybQKWFGGgXlQGSSHIXK/PtQQYbM9ArcgPWOlVJ1Q4TgFGTLGD
 fWpcuCcpLGrtLN6g59g4m07V9FTVekCNGOYn0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792187228; x=1792792028;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:references:in-reply-to:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=bzjpyNu8TDsZHs3OelkLBVEV0pcZ39Ces7ch7uiV7SI=;
 b=GjWcwNVXXwvZzENMaVN2AU9fDSxg3XPmRCkotNgtuTPXt5qEYA7V6jAV602FIV/M3S
 JZhlho0sLSdMGqMgTegwSHQZMqt7rswWoOq9QlGdklAxq8w/S4qb+yN6q6k6MQEfr+pL
 6/+BqIR78/wWTmk9n/sfYiyelzXdmQS77tVms1Nwnn/MJs9mqeu1uPw6vKhq+zVQmwc4
 6vvNkmRVMLHT5UM/5DhsWgprOnF6QhfDHNf0biZlMI9j7thUxo6VUp1idLDQcW1px5EB
 RtqbXBjbcnn7JgtPbULxTdl7NvZoYNptf/c4v+hZUnzpT6dxCbFHmfNXrGFVkn52SKkI
 Qm7Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBxOTwYk1qIcqU/t9b4tPO91zxVs8X0qp0ZPn0TgZH0Rhx0qjWbbCDrVQ8Is30NCW7vrzdkZVoI=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYLgDY9YIz0M6ra8WKxC2w3bUgKCXUiWHIu7GlTzgo7W+mmwO0SH
 8udl6DUou8N1ogzWJlZsyH2t+rvMNIgiq20xAjCfMlBjQCdyTViaVQyqXiOquB8NgUWExZrNe3z
 i67M08295UNytRqkX6EnXAiCHfq91XZYMagAtmDQK
X-Gm-Gg: AYBFou0J41Yvk6QUBykIPNdkOC6E3NaCXk3vGj11Ed1yiHHEFUyAqAQIaUtpxMrw80V
 WCMHe7g2O2xdvGxA4a4SeIiW0stwmzNT/C5IdHqHWM+IYgbRrz7brKJ+txKGFNkFcHbP9fxfh6Y
 7kzLxtAEISGj0FiOTFn3yqDm7hX3ViBl0l32R88ECte5l78pHGqnOxoS6Uf2CCB5PjBxziKA2gs
 pN8xeiD9u/4IYoeSU3vaQlgkFnuhk186fo4qx97MPqSEATa/bDxOlqgvf5JylN9n461F2lAU1WS
 Gvzcmr2XylQGMre7jLjINrHv7n1H/70fT9QBG/KNHsSc/YDImt6HBQ==
X-Received: by 2002:a17:907:944a:b0:c32:1b0d:d774 with SMTP id
 a640c23a62f3a-c41a0cd3224mr72626766b.49.1792187227890; Fri, 16 Oct 2026
 14:47:07 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 16 Oct 2026 14:47:06 -0700
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 16 Oct 2026 14:46:27 -0700
MIME-Version: 1.0
In-Reply-To: <20261014190631.2232208-2-alan.tseng.cs@gmail.com>
References: <20261014190631.2232208-1-alan.tseng.cs@gmail.com>
 <20261014190631.2232208-2-alan.tseng.cs@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 16 Oct 2026 14:47:06 -0700
X-Gm-Features: AclHuK8CRjh9UrJJ5Gn7u4uXFRa-akNMIGQOack5rra6OA9-BugJGFzb8q1797Y
Message-ID: <CAFLszTjsr-UMEXUAM8JeB8qOPW4m1m-82x7niLHyeZ-TQTW9Eg@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] virtio: rtc: Add virtio RTC driver
To: alan.tseng.cs@gmail.com
Cc: Bin Meng <bmeng.cn@gmail.com>, Tom Rini <trini@konsulko.com>, 
 Kuan-Wei Chiu <visitorckw@gmail.com>, Simon Glass <sjg@chromium.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, u-boot@lists.u-boot-project.org
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

Hi Hung-Chun,

On 2026-10-14T19:06:28, Hung-Chun Tseng <alan.tseng.cs@gmail.com> wrote:
> virtio: rtc: Add virtio RTC driver
>
> Add a driver for the virtio RTC device (virtio device ID 17), which
> QEMU provides as virtio-rtc-pci and virtio-rtc-device since v11.1.0.
>
> The device exposes its clocks through a request virtqueue. As the
> virtqueue must not be used before the virtio uclass sets DRIVER_OK,
> which happens after probe(), the first read looks for the clock: it
> asks for the number of clocks with VIRTIO_RTC_REQ_CFG and picks the
> first one whose VIRTIO_RTC_REQ_CLOCK_CAP type is UTC, smeared UTC or
> maybe-smeared UTC. Reading the time sends a VIRTIO_RTC_REQ_READ for
> that clock and converts the nanoseconds since the epoch with
> rtc_to_tm(). The clocks are read-only, so there is no set operation,
> and the optional alarm feature is not negotiated.
>
> VIRTIO_RTC defaults to y when VIRTIO and DM_RTC are enabled, like
> VIRTIO_RNG does for DM_RNG.
>
> Signed-off-by: Hung-Chun Tseng <alan.tseng.cs@gmail.com>
>
> drivers/virtio/Kconfig         |   9 ++
>  drivers/virtio/Makefile        |   1 +
>  drivers/virtio/virtio-uclass.c |   1 +
>  drivers/virtio/virtio_rtc.c    | 213 +++++++++++++++++++++++++++++++++++=
++++++
>  include/virtio.h               |   4 +-
>  5 files changed, 227 insertions(+), 1 deletion(-)

> On sandbox, where VIRTIO_RTC now defaults to y,
> "ut dm rtc*" and "ut dm virtio*" pass.

Just to clarify, the sandbox virtio transport only exposes a
VIRTIO_ID_BLOCK device (see uc_priv->device in
drivers/virtio/virtio_sandbox.c), so neither of those actually probes
virtio_rtc =E2=80=94 they only confirm the driver builds. Please mention th=
at
in the commit message. A sandbox test along the lines of
test/dm/virtio_rng.c would be good as a follow-up.

> diff --git a/drivers/virtio/Kconfig b/drivers/virtio/Kconfig
> @@ -84,4 +84,13 @@ config VIRTIO_9P
> +config VIRTIO_RTC
> +	bool "virtio RTC driver"
> +	depends on DM_RTC
> +	depends on VIRTIO
> +	default y
> +	help
> +	  This is the virtual RTC driver. It reads the UTC clock of a
> +	  virtio RTC device. It can be used with QEMU based targets.

Please can you expand the help text - something like "This enables the
virtio RTC driver, which reads the UTC clock exposed by a virtio RTC
device (QEMU v11.1.0 or later provides virtio-rtc-pci and
virtio-rtc-device). The clocks are read-only, so the time cannot be
set."

> diff --git a/drivers/virtio/virtio_rtc.c b/drivers/virtio/virtio_rtc.c
> @@ -0,0 +1,213 @@
> +static int virtio_rtc_get(struct udevice *dev, struct rtc_time *time)
> +{
> +	struct virtio_rtc_priv *priv =3D dev_get_priv(dev);
> +	struct virtio_rtc_req_clock req =3D {
> +		.head.msg_type =3D cpu_to_le16(VIRTIO_RTC_REQ_READ),
> +	};
> +	struct virtio_rtc_resp_read resp =3D {};
> +	u64 now;
> +	int ret;
> +
> +	/*
> +	 * The virtqueue must not be used before DRIVER_OK, which the virtio
> +	 * uclass sets only after probe(), so look for the clock on first use.
> +	 */
> +	if (!priv->clock_found) {
> +		ret =3D virtio_rtc_find_utc_clock(dev);
> +		if (ret)
> +			return ret;
> +	}

If the first find fails (e.g. a device with only TAI or MONOTONIC
clocks), clock_found stays false and every subsequent 'date' re-walks
every clock. Since the clock set is fixed for the life of the device,
please cache the failure too - e.g. a state enum or a cached error
code =E2=80=94 so the second call returns immediately.

Regards,
Simon
