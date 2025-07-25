Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6753C87FCE
	for <u-boot@archiver.kernel.org>; Fri, 25 Jul 2025 13:33:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 52C9483981;
	Fri, 25 Jul 2025 15:33:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="SHJMirS1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AA1D58398C; Fri, 25 Jul 2025 15:33:42 +0200 (CEST)
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com
 [IPv6:2a00:1450:4864:20::12a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B2FBA83980
 for <u-boot@lists.denx.de>; Fri, 25 Jul 2025 15:33:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-55516abe02cso2737346e87.0
 for <u-boot@lists.denx.de>; Fri, 25 Jul 2025 06:33:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1753450420; x=1754055220; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fOWrm2KwV1FYaHWjbmHjgUVexQ5adzWecF32fUxypNM=;
 b=SHJMirS1cJYkI2MsGrGMLACQTS07VmBd0Sdd9AI1FgikZ9yyxLApX/zRHgjLESv2CT
 K0AVMrKMO0T91GUjC4AZBRD+dctisSFWTR+V5NhQrI5ymYVodW44DV8NZCAxuXWUGPZ2
 xLTROl1ttWYiCNFsqpq9FapcGeJYb5HVvo9PVVCsEmHJcSy1etRl+dvgPwdNS38GhhWR
 yztMBx/vYwoiMEvrX4bfqp6np9AW1FweESkAmQmiEb+ivgi2IBkItI1FrVvaATNp1CDY
 9/hopc9aklGZTUy+a5DMVexbBomxduCuzqsdGIqU0JCwJAo2hcmRUBpWrQFnj8rthm03
 mBCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753450420; x=1754055220;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fOWrm2KwV1FYaHWjbmHjgUVexQ5adzWecF32fUxypNM=;
 b=HsOnqe+I4gPllz6S4fRutbDRm4tyxHO7cld7pKt7SlA5YkmVJIPJGY/ongO7sfXDCo
 8axvjzJLDDiEraEnxb23h8WXUI3hQUoh6UW6bppjAbPlKVQ+k14QSA6s7m64JbkaMflm
 B3CIxEMcXFyQsR5AZq/KvD52Wvffk123HX9kvbDSNABBxlNma4vTVhqhNFwNXtoApzJB
 ZIC9zW0MyBbBrqjWYljL9qujHXPNYdq3zjtuf59ncf4wSNt0m8zYM4Jvtb/3zoXZJcgs
 oO3/BtBExTo1CSD+LgRhPVR9eJT24qP1wUj6xjBPfd9Ca+S4mrB4N3BBOUrtPS3MJZn/
 ctrQ==
X-Gm-Message-State: AOJu0YzYAvi8WBIO4m6qZJdliPFDRjF9aCG53JmUK+KX2mggLAuDlsGH
 1zhuYCax5v1AQEJsbE2+hdCdn9e524DeYRTGFPu/bD0JZhZ2npdI9KR53QR9OagOFYMhmaK8EGg
 2FydBBBRWLAD6043nF6RtyeHTZjkUZEk=
X-Gm-Gg: ASbGncupCSYdBvBt8kRVGpmz9o71Wm3ZyK9llcr4mS1GMH6PcyF44HFt54RlvP8oqPv
 SyS4ThzNyX2mWefxuuz1CtUHsmJNZEbRPJhMk1GNm2BWSlSyi46xGXOsQ4gxe6yjn/P75qt+YRU
 YUnGNVCNb4X299Vf3ZSTStB0gK3RZV6aLyt+vGCRzxzxw44dSSZijsLzjP8ygsefeYdTDZCLqns
 Yi6iEW+MG4ByWFbbZ3xRfruSXPvalBfs2ZvlRs=
X-Google-Smtp-Source: AGHT+IH91ftgSiuh4MqsiXaWaWK7l1UIYEoZ9k8X8Fbcem8x0xoaD8dt3gKVT72qs59FK3d7H5pMMjFRDOYFs/OOhEQ=
X-Received: by 2002:a05:6512:224a:b0:550:e8b6:6996 with SMTP id
 2adb3069b0e04-55b55846d3amr1856332e87.2.1753450419803; Fri, 25 Jul 2025
 06:33:39 -0700 (PDT)
MIME-Version: 1.0
References: <20250709153623.3038697-1-tharvey@gateworks.com>
 <20250709153623.3038697-2-tharvey@gateworks.com>
In-Reply-To: <20250709153623.3038697-2-tharvey@gateworks.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Fri, 25 Jul 2025 10:33:27 -0300
X-Gm-Features: Ac12FXwQERzNG7C3E8qqEGrH8r5Ad9kAgDznXQ8kUblhpegF86IKUbSK0JqXMiI
Message-ID: <CAOMZO5DiW1Mvw5trGw9oW8S7bFANwKuxfZPt+QyJPZZKWVmxaw@mail.gmail.com>
Subject: Re: [v2 PATCH 2/2] imx8mp-venice: enable USB device mode
To: Tim Harvey <tharvey@gateworks.com>
Cc: u-boot@lists.denx.de, Stefano Babic <sbabic@denx.de>, 
 "NXP i . MX U-Boot Team" <uboot-imx@nxp.com>, Tom Rini <trini@konsulko.com>,
 Marek Vasut <marex@denx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Hi Tim,

On Wed, Jul 9, 2025 at 12:36=E2=80=AFPM Tim Harvey <tharvey@gateworks.com> =
wrote:
>
> Now that we can determine device role via a usb-connector ID pin,
> remove the host-only mode dt override and enable additional USB
> device mode support.
>
> Signed-off-by: Tim Harvey <tharvey@gateworks.com>

Please resend it after the driver part has been applied.

Thanks
