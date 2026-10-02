Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA700CA5FDD
	for <u-boot@archiver.kernel.org>; Fri,  2 Oct 2026 21:31:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 95B0881415;
	Fri,  2 Oct 2026 21:31:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6NsqnvbzDm_s; Fri,  2 Oct 2026 21:31:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org CC15F813EB
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790976690;
	b=pfh/Xmptz78cC7bT0g5wfCRwVsa4x7eBKSz1Njyehp3iZG4BWqs7Ln6EVGXswyofnmIy
	 weTpEjCjrSTP4+H4cOQOQn4fBUETW0WC7Uqmbkim5vX2o5vx5WPJaDdfVYPGYelsRMK2X
	 iBThbjah5ugUzgrU7wvzlDsrfYMsPXRQicEmyFoqIuyoyrQ4Uz96ErGL/qVXbc+ax40HS
	 yAnuy+hi4+j00nMZ2sqzdJv/B8RM0bEpimJVvhkyu3FR5IbDA2RlATjzY3e3Y327+ZlMl
	 IwYNuzWwVw4NtgX36OL8VnjMFFOSJhUX+TtotKfuuWD3SEsy8EaQ36gH9Tjlz7YTGnA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790976690;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Greylist:Received-SPF:Received:
	 DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:In-Reply-To:
	 References:Feedback-ID:X-Pm-Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=keLPcT02avP3tFNZfCs716bP4sYTsVBv01BUeehMgRY=;
	b=V2g5eC9IxZcP3I0Giz1efEFT0aoQ7v9bICiIF77tExZ8lko5U8phMhkPkXA2jiLKM6AM
	 8uY1ORJJF9Jn+lveBKxuZd32FFeKbha/0nrBYL7NnH0foUM4BYzw6dRbJvj4FTpFBS3/8
	 70NxrgYHNwlgYbOPNfFSS6PKL06tW+LIksTpHKjbXAU75yDLqJl2N8c6fu0jD5AU3NNvM
	 NeRe+W+Wg+hx+t1CWB3Rh7KtNVfAqOS39LauKuaARRwtAf4PS2+zsx064KR+fjra6QF4H
	 1wK37YtPVnIoq1JJS9lL6oX2nzN+F/rvLVhVk/d1mGoER6QAYoi/ED6QwMzbbudHyqA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790976689;
	bh=keLPcT02avP3tFNZfCs716bP4sYTsVBv01BUeehMgRY=;
	h=Date:To:From:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Y+U8A7cz7j0PLyMvhz3m8f5MVhT+85VdVWSwGVJ5lD+58cQsl/MTcrCElPaJ57F+u
	 bD5Shbiqa4TYnjf7NrgXBV8Cd6+HxVtyzDETorQsm8sXDM7m22lqADlVUPmPs7C5Xg
	 7u9h/xYJQli2LiG9Lw+aMQsT8EIFEzxDly1IcQJAjuLPpLWhGyHkb0ejl6HKUaj+3C
	 aad7pI2zFuc9Noy0LB5iXhtzQTQeo81Oo4gKeg/Sln23ejmNAhvVeiiuWZGOfEJZUB
	 y8IPP0ul+6nZ90GU1avMLY+dMrmiFcIGDtTa6vbY4r+5bQQWTeNvHqbAaVjnRdhqY9
	 A9F0500nDTxYQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id CC15F813EB;
	Fri,  2 Oct 2026 21:31:29 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 841BE2E0
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 21:31:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 6A2EA40DEF
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 21:31:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fFKMVVk4Q7Nn for <u-boot@lists.u-boot-project.org>;
 Fri,  2 Oct 2026 21:31:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 5751D40DED
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=185.70.43.102
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790976671;
 b=hojh4o96VP2mID1dC9h4I+nC/K2Ls1DhoL9SE9pewb1Duj8tGy9y+VZzPPlVG2v1oMcP
 UgKfaV7KmF522Rq7ASoqXk2nssplu4u+Ad/LCz8Pe+tVMUDi4CrDTyQkK/DmafQ892N0R
 Ra/Hep4qTqXxkukxaNRVgLdsgnQ5vSay9myeBIm2aJ+ar8cKWUYax+fc6AcAiBIBAcky3
 UJIBTWS0kxfjhh18nXe3T96c13pgYYfprpOE5Ag1jBCLXk2s6WXJqBGMLKGSMR+CisZPt
 kERF4c0q+ZE2LFs7BO5ak0PbdgvDSXaqbz/19IoLlX+NogiHtivD4IBgleAcJihQFXA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790976671;
 h=X-Greylist:Received-SPF:DKIM-Signature:Date:To:From:Cc:Subject:
 Message-ID:In-Reply-To:References:Feedback-ID:X-Pm-Message-ID:
 MIME-Version:Content-Type:Content-Transfer-Encoding;
 bh=keLPcT02avP3tFNZfCs716bP4sYTsVBv01BUeehMgRY=;
 b=lo10fN3GkEaIhwum8xxPuYcXwA6Q82FvjT++4/qC0HUfsyLODYnsRwXBfa3fC7WKDJN3
 zwux0TMtN3Oexa/QBFKR3ubSSMKXvIuwsGAZHENUaT9f8UQDHcaEkGeCv0Sf7wdZT8Qcj
 ZHkOt4FIjx/PD7itdPkG/WhLjvYqYTI+1lqjDmsEf3feOSXSNFTUEvtm3QzIwPkmidVmO
 YRQCfcZbdlSlzRb393iOR8DbDODWt9zf1ZE7T/fb+VkUexyYEmm0vZTrVoangirqTQVCn
 d8G9Cv+3fXa6v/Tj0ZFllDJWCaQD9VZH0oPh3muiWM4qrJa6+neyBT545PfeDwIDS2Q==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=protonmail.com; 
 dkim=pass header.d=protonmail.com header.i=@protonmail.com header.a=rsa-sha256
 header.s=protonmail3 header.b=y49wsVCD; 
 arc=none smtp.remote-ip=185.70.43.102
X-Greylist: delayed 102 seconds by postgrey-1.37 at util1.osuosl.org;
 Fri, 02 Oct 2026 21:31:11 UTC
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=protonmail.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=protonmail.com header.i=@protonmail.com
 header.a=rsa-sha256 header.s=protonmail3 header.b=y49wsVCD
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.70.43.102;
 helo=mail-43102.protonmail.ch; envelope-from=davewk225@protonmail.com;
 receiver=<UNKNOWN> 
Received: from mail-43102.protonmail.ch (mail-43102.protonmail.ch
 [185.70.43.102])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5751D40DED
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 21:31:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
 s=protonmail3; t=1790976667; x=1791235867;
 bh=keLPcT02avP3tFNZfCs716bP4sYTsVBv01BUeehMgRY=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=y49wsVCDc0i3Zd7dsTTwPddKwSm5HazMrMx/U8SR0ceNfNFyun91bILqDMxlW5CHV
 tdv86MdO+MHM4kdSNBfcAt1ZTj02BO46CF2rcykuRCwjBssNt7/dSdTapmPXj6WHfJ
 wUVTSccA8alluGHdIHe0lY7Z1djhtOaEAaWAscYpeqGSwIyrJRdfd5/O07WyErvTg1
 2i6PYfqt7m15LEYmX35JtFAPwz4Gk8cZdmz60kX/8KPsJhDapJixPRrOjkjEeQvI4a
 QLgcbW3z6f54KI51hdLFKslQ/QmUeoWm4G76VErPae8AUf0dW/90pgt0sZC78W2Y+u
 LvoKTnuVrrasA==
Date: Fri, 02 Oct 2026 21:31:01 +0000
To: u-boot@lists.u-boot-project.org
From: Dave Klotz <DaveWK225@protonmail.com>
Cc: Huan Zhou <pericycle.cc@gmail.com>, Eric Chung <eric.chung@riscstar.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Yixun Lan <dlan@kernel.org>,
 Tom Rini <trini@konsulko.com>, u-boot-spacemit@groups.io
Subject: [PATCH 5/9] pci: spacemit: report link up from the link status
 register
Message-ID: <a249fa2eb6aa4ce01b9e09b54964a0efe09d8264.1790975598.git.DaveWK225@protonmail.com>
In-Reply-To: <cover.1790975598.git.DaveWK225@protonmail.com>
References: <cover.1790975598.git.DaveWK225@protonmail.com>
Feedback-ID: 100562830:user:proton
X-Pm-Message-ID: d728e781fcf264f1c818ff23530ef8f5bf077e98
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Fri, 02 Oct 2026 21:31:20 +0000
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

The driver decides the link is up when the LTSSM state in the
DesignWare PORT_DEBUG0 register reads L0. L0 is a physical layer state;
the data link layer may not be up yet, and config requests sent before
it is are lost.

Linux's pcie-spacemit-k1 driver reads the link status register in the
"link" window instead, and needs both SMLH_LINK_UP (physical layer) and
RDLH_LINK_UP (data link layer); FreeBSD's spacemit_pcie driver does the
same. The window is already mapped (as phy_ahb) and the bits already
defined, but nothing read them. Use them, and drop the now unused
PORT_DEBUG0 definitions.

Signed-off-by: Dave Klotz <DaveWK225@protonmail.com>
---
 drivers/pci/pcie_dw_spacemit.c | 9 ++++++---
 drivers/pci/pcie_dw_spacemit.h | 5 -----
 2 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/pcie_dw_spacemit.c b/drivers/pci/pcie_dw_spacemit.=
c
index 5e0871986b..3394ddbd18 100644
--- a/drivers/pci/pcie_dw_spacemit.c
+++ b/drivers/pci/pcie_dw_spacemit.c
@@ -81,10 +81,13 @@ static int is_link_up(struct pcie_dw_spacemit *pci)
 {
 =09u32 val;
=20
-=09val =3D readl(pci->dw.dbi_base + PCIE_PORT_DEBUG0);
-=09val &=3D PORT_LOGIC_LTSSM_STATE_MASK;
+=09/*
+=09 * As in Linux, the link is up once both the physical layer (SMLH)
+=09 * and the data link layer (RDLH) report it.
+=09 */
+=09val =3D spacemit_pcie_phy_ahb_readl(pci, K1X_PHY_AHB_LINK_STS);
=20
-=09return (val =3D=3D PORT_LOGIC_LTSSM_STATE_L0);
+=09return (val & SMLH_LINK_UP) && (val & RDLH_LINK_UP);
 }
=20
 static int wait_link_up(struct pcie_dw_spacemit *pci)
diff --git a/drivers/pci/pcie_dw_spacemit.h b/drivers/pci/pcie_dw_spacemit.=
h
index 2c17f113b7..6f198f7d58 100644
--- a/drivers/pci/pcie_dw_spacemit.h
+++ b/drivers/pci/pcie_dw_spacemit.h
@@ -22,11 +22,6 @@
 #define PCIE_MISC_CONTROL_1_OFF=090x8bc
 #define PCIE_DBI_RO_WR_EN=09=09BIT(0)
=20
-#define PLR_OFFSET=09=09=090x700
-#define PCIE_PORT_DEBUG0=09=09(PLR_OFFSET + 0x28)
-#define PORT_LOGIC_LTSSM_STATE_MASK=090x1f
-#define PORT_LOGIC_LTSSM_STATE_L0=090x11
-
 #define PCIE_LINK_UP_TIMEOUT_MS=09=091000
=20
 /* Vendor and device IDs */
--=20
2.55.0


