Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF287F43699
	for <u-boot@archiver.kernel.org>; Fri, 17 Apr 2026 12:47:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D0AA7843B8;
	Fri, 17 Apr 2026 14:44:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=infineon.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=infineon.com header.i=@infineon.com header.b="PfVJBNId";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0C59E83FC0; Fri, 17 Apr 2026 08:56:11 +0200 (CEST)
Received: from smtp11.infineon.com (smtp11.infineon.com
 [IPv6:2a00:18f0:1e00:4::5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9E43983BC8
 for <u-boot@lists.denx.de>; Fri, 17 Apr 2026 08:56:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=infineon.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Takahiro.Kuwano@infineon.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
 t=1776408969; x=1807944969;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=kYw5FrxWO0X9q/E48RUrXTatyz9wKLADCdH0Ttthjhw=;
 b=PfVJBNIdjMPxS0Fp+6MRziQepDeb/POvLMe832DCf9py5cH+gO/HDd19
 kbFx0DTn4/5yXTxCffHB3nPXqfFvpabMp3bpJDKxIG0nEkFn6BXl8UTLG
 DoutLB/vPgl/pSnhyc2VbCKPrkaDtiYVXLSEiS/jB/oti2Gb1Q+x1QTIO A=;
X-CSE-ConnectionGUID: DG1Q41U5QayXehLRg5/mSw==
X-CSE-MsgGUID: SVN+Bm+IQhyTvtuQRGIVvg==
X-IronPort-AV: E=McAfee;i="6800,10657,11761"; a="139703477"
X-IronPort-AV: E=Sophos;i="6.23,183,1770591600"; d="scan'208";a="139703477"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO MUCSE819.infineon.com) ([172.23.29.45])
 by smtp11.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Apr 2026 08:56:08 +0200
Received: from MUCSE820.infineon.com (172.23.29.46) by MUCSE819.infineon.com
 (172.23.29.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Fri, 17 Apr
 2026 08:56:07 +0200
Received: from MUCSE815.infineon.com (172.23.29.41) by MUCSE820.infineon.com
 (172.23.29.46) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Fri, 17 Apr
 2026 08:56:07 +0200
Received: from MUCSE815.infineon.com ([fe80::b54c:c0bd:546c:c9be]) by
 MUCSE815.infineon.com ([fe80::b54c:c0bd:546c:c9be%12]) with mapi id
 15.02.2562.037; Fri, 17 Apr 2026 08:56:07 +0200
From: <Takahiro.Kuwano@infineon.com>
To: <ycliang@andestech.com>, <u-boot@lists.denx.de>
CC: <trini@konsulko.com>, <vigneshr@ti.com>, <jagan@amarulasolutions.com>
Subject: RE: [PATCH 7/8] mtd: spi-nor: Add Macronix MX25U quad-mode fixups
Thread-Topic: [PATCH 7/8] mtd: spi-nor: Add Macronix MX25U quad-mode fixups
Thread-Index: AQHczhOgqU/L8UldzkqcbNLaB4seTrXiwWfg
Date: Fri, 17 Apr 2026 06:56:07 +0000
Message-ID: <ca890128e0064358aa4b94d4ac41af4e@infineon.com>
References: <20260417024034.4046667-1-ycliang@andestech.com>
 <20260417024034.4046667-3-ycliang@andestech.com>
In-Reply-To: <20260417024034.4046667-3-ycliang@andestech.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.161.6.196]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Mailman-Approved-At: Fri, 17 Apr 2026 14:43:59 +0200
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

Hi,

SPI-NOR subsystem needs cleanup [1] and we should refrain from patching on =
top
of current code.

It would be really helpful and appreciated if you can test your patch on to=
p
of the series [2] and share the result. The series intends to isolate the
logic specific to AMD platforms. We need to identify the problems if any in
other platforms.

[1] https://lore.kernel.org/u-boot/20260213164607.GI2747538@bill-the-cat/#t
[2] https://patchwork.ozlabs.org/project/uboot/cover/20251119-amd-cleanup-v=
1-0-c555bd85e6e4@infineon.com/

Best Regards,
Takahiro Kuwano <takahiro.kuwano@infineon.com>

