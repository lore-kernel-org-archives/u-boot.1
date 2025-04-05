Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D677C36010
	for <u-boot@archiver.kernel.org>; Sat,  5 Apr 2025 22:33:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 61C9982ACF;
	Sun,  6 Apr 2025 00:33:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="LSUON01T";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F1B8682B00; Sun,  6 Apr 2025 00:33:32 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D230E82ABA
 for <u-boot@lists.denx.de>; Sun,  6 Apr 2025 00:33:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1743892395; x=1744497195; i=xypron.glpk@gmx.de;
 bh=RkPcEylS3VZILw/+UrBA/r8THaS0ZL5WC4FtPgxs8GI=;
 h=X-UI-Sender-Class:Date:From:To:CC:Subject:In-Reply-To:References:
 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=LSUON01Tg+shyYz/SEklXT0kJqulmEr2ty6C/qKNDg7vBv6YfCRf/RPVkSgRcsPD
 XQl+2LJjLIdMkhX34vXIOYI/XlcInruqh1F1XR4kIo7Kuk906a2fzPG3n4C3ZZSFr
 PWTYHhiWVmZ21KBHGZDvOCDK5mlL1aTNW98I8p0QzZYu3tQau2YZeNERN/wGqf2Y5
 dGZnqFm0ZH65kQ7LTLAGdx0yIt8t40HnOCflAzlDcj5n+Dq35NB0osT/+chQs0OYo
 hllSRbOkLNR/OEg7A++IZO1dknvPX3By12917b5ob7dS/q1qsCa/FTj72hmsHBOw5
 evpD8S3akS2wxiTGWA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [127.0.0.1] ([46.114.104.243]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M2f5T-1u4ki52n1T-001zB1; Sun, 06
 Apr 2025 00:33:15 +0200
Date: Sun, 06 Apr 2025 00:33:10 +0200
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
CC: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, neil.armstrong@linaro.org,
 =?ISO-8859-1?Q?Christian_Kohlsch=FCtter?= <christian@kohlschutter.com>,
 Jim Liu <jim.t90615@gmail.com>, Joe Hershberger <joe.hershberger@ni.com>,
 Kongyang Liu <seashell11234455@gmail.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Parvathi Bhogaraju <pbhogaraju@microsoft.com>,
 Ramon Fried <rfried.dev@gmail.com>
Subject: Re: [PATCH 1/3] net: designware: Disable DMA on removal
User-Agent: Thunderbird for Android
In-Reply-To: <20250405221308.498047-1-sjg@chromium.org>
References: <20250405221308.498047-1-sjg@chromium.org>
Message-ID: <ACF37B17-076C-46D6-8B06-3C8693333932@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:rYN4xsgWg9QGOr+JuGI0QKTtnUSM9F8p9uFw/7FaSAIUEZB6yW4
 VQu0iuGBd+Kwsare755HvMN211y2gzd11mMslXICZtNhvK6dtI2bBgb6tzcbCthDcUunZbp
 ZsakjwDDdZWbQYxvFhMc14LgqKtufFfG/NLBLNPy1kh6xPDXIB382ZEh7EMfg3EDb6/s4Ol
 J1KoGnrzMHcLOsgwKrx3A==
UI-OutboundReport: notjunk:1;M01:P0:vfl4gGeRDR0=;we832PW4Z6M6kamYSLAXtKQUfzI
 epKSkPNPoyPj1FILbKc0Xmb1auo/7sbxgxELfXAqiHYj9u/Nem5TOrRW5DpW1PQFEqEAh/a5Y
 RIN+Hp4Hxh8/A7pdclSTRvvq86UV++eqRFbwERutsqlJhUBRpT/mNBILmqrt8KE8yC5ZtljJR
 rO2ToT544WwNE20NQX2uVFNw5Ay2Y1qHy9luGwmIV9XIEeHgD+kpP48FuVsn4qTLdB6CeroeS
 tdMslrwD2jwbDpwytBDHVUo9e7h7ewaOCFGC4iA8JNRZQBFBAtF58Zuhr6P4ifOSIsGBFP7OC
 IPpNhqAVPdY4T4XMV5jurM+Uie9M9bQwttoqpv/PusH75QPCwVwvaVzS9EJGABLNR2QDphXLT
 exIxfH2stG03XzrLmDzuA11Dx51vjJX6vWDKHWOdKxvjZ6nfuMDDSudcQ1wvM6TpKp8PlhrEQ
 5tiVUEeH1mo7rnp5z4sN9xOb5XOiX6clYTWepl4GRAVNdXBjMf6AT/akPLvhmUb1X2UGBHpbx
 Ha5jI5KM+iWETMXR4vqvmNoz+IqaUD0k1Cku76hDvDhhRIFyi8veztdL2cDjpLs4wCAWYpY2J
 pBi5pEiiSZp54SMx1JECAoyKMNQP9obC3dwhJCd0zzVDR3sO2KlIbGLX5gSHZ/3ABYq3SwdFF
 tG5TVOHm9uW3BlGydlpdaDlQ9JAehOo2ISWqg81MxMrXbWTyljatXllTQ4oXjeEf9jUl10qwb
 TcT1TdACXb6MUqz3c3WtcIozeUtCxwwsX44h2qLMIvdLqqU9Rix5JfgvcijKLLFDO0cHFYiSZ
 FtRZ6qm2MN0Dew4IlpKl8vUmSLSrP+TSOeLTNCBg4pRsc5O5Gow9FfgimNUJN1NXJ+8pbw7yY
 bywk5o46e990EbYbOIgJ+W/0a4Z6FOV3xNjiUEVIiwDYKrbloRqVBYZ8VerrhM7S1DTlj1wo+
 cFVDywuNdxbruwKvD9Qbb19ON9Vwqq/3AFIeugm2pxLgYMzxwT3LoCd+/I5SMnfLlOFk4FCd6
 7R6V16P6PZOlaAGylYLAx1b1lRggT/C2yRQnT2yPhgW2ODT6a7zN5IWA4It5t8R1waOUpbJoY
 OrLWeLOWwqpY2++n+KHVNT8Exc2O4J88sJFp2jVw7mEVmgTm/WjYQharP+DeiwbaJ6P+rTrJG
 RW4yFYxNHgH4+VkGCWneNaU9bLvj1ob2ANx8IUp7u+JcZRR4C0a8VBfrZ2wc4fayqBQqE61OU
 GcxVVByUP1B0KntIw+FysrZ//3BPy/r0j7E9B/nW9rohyB/YTCZe/ohKnLo29R0ZKT9IucG2U
 Xz0ewVfk5AwLgUv29lCuUHV0cgq+/FLaXPo6qIhaA4db14BuGcYJASLkfKTau3cWu23Pw4AiS
 /S5ziBa9YQOc/t5fGHdSIbZBFTUCCdHtvqOpP5umKnm964leA9fFhlRtqPDy/ZDyx/nz2bu9x
 IslJyYjHnfARj0BTZtSuIT8GH+QsF2FRrmCO1o9LFxEY2kx5x
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

Am 6=2E April 2025 00:12:45 MESZ schrieb Simon Glass <sjg@chromium=2Eorg>:
>At present, removing the device frees struct dw_eth_dev but does not
>disable DMA=2E When DMA is active, packets can be received even if the
>driver is not active=2E
>
>While it is possible that the memory used by the struct may remain
>untouched after removal, any other allocation may reuse that memory
>and result in DMA writing to random addresses=2E
>
>In most case U-Boot does this removal in announce_and_cleanup()
>immediately before jumping to the OS=2E No further allocations are done
>after that point=2E
>
>But with EFI_LOADER this function is not called before jumping to the
>EFI app=2E U-Boot continues to run while GRUB starts and finishes, as wel=
l
>as while Linux is starting up=2E During this time, devices cannot be
>removed, as they are in use=2E U-Boot completes the removal when
>efi_exit_boot_services() is called=2E It seems that this function does
>more allocations after calling dm_remove_devices_active() although I
>can't figure out where=2E
>
>Fix this by disabling DMA when the driver is removed=2E
>
>Signed-off-by: Simon Glass <sjg@chromium=2Eorg>
>Reported-by: Christian Kohlsch=C3=BCtter <christian@kohlschutter=2Ecom>

LGTM

Acked-by: Heinrich Schuchardt <xypron=2Eglpk@gmx=2Ede>


>---
>
> drivers/net/designware=2Ec | 1 +
> 1 file changed, 1 insertion(+)
>
>diff --git a/drivers/net/designware=2Ec b/drivers/net/designware=2Ec
>index 07b0f49ef58=2E=2Eeebf14bd51a 100644
>--- a/drivers/net/designware=2Ec
>+++ b/drivers/net/designware=2Ec
>@@ -809,6 +809,7 @@ static int designware_eth_remove(struct udevice *dev)
> {
> 	struct dw_eth_dev *priv =3D dev_get_priv(dev);
>=20
>+	_dw_eth_halt(priv);
> 	free(priv->phydev);
> 	mdio_unregister(priv->bus);
> 	mdio_free(priv->bus);

