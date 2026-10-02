Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3E16CA5FE4
	for <u-boot@archiver.kernel.org>; Fri,  2 Oct 2026 21:32:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9A15560D9E;
	Fri,  2 Oct 2026 21:32:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QkhgtaJZjyAI; Fri,  2 Oct 2026 21:32:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org D66056064B
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790976725;
	b=jgDrDJahecyjXS0KCytunkBWkPjgQYFJZljzgG1R01zNXhnstgZo/UaXRH1zOxmaKwHy
	 6eRG2ukEc7DWaEpdsaz2pUN5FKgYbiOqFylkSmjFNRY4Ew+qb5jEO42iZWmT366kDgfWg
	 6UpmsVkC7lWLXt+RUwX6w3X6inckG9e5a3hks8Aafwm1DbtWLJpByLF0mo3teKD1Gzehp
	 5QKvn/b+bfuMRtGxxU7nctl+zLpqXTYlFUFH+dYZovJRzFTWQv9KFFAMC3kAAd0ebIUH4
	 eKVhJSypbT6ZJ8Zwp6lAckkepgzntBmm+ehRLhg54HK7bZiy6CzZKmQ5EQqryEG9jVg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790976725;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:In-Reply-To:
	 References:Feedback-ID:X-Pm-Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=+nzUmCh/xOwOnYLzD8k4DDXYdVCD9cDDSxtfM4YfXGY=;
	b=Vqdd1Emo3ftMjGlRnRjatC/QtxSnO12xJ2hreljqktr3AKGgArVNoqAhJklOjYuEn0Nx
	 bbNsNfgyiFQPxEvfspdyGbY5qtEwqE9h5AeV0NCud0NVKbJwDKmG/ImhCDndfAqTTfotL
	 f1TJAnSFodRjxAROPKj+cSL77gyHy5lLVCahViNZGGPbjhptU1EPBWv53MX4imAKYlNxm
	 eN02BJR7QpV7vJh7o8nLIGLrVIvPC78tRJYbI5smcJytBnbQVlqE0pb3YvU2LuEsmdgoF
	 SHdh3OhOoKbny05EY+vEgKE+hrZZnQ5baXgjpc1ykfJnLnVF+SJjM7H3Yl9jCzzFC7A==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790976725;
	bh=+nzUmCh/xOwOnYLzD8k4DDXYdVCD9cDDSxtfM4YfXGY=;
	h=Date:To:From:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=O/xc1lwimtFLrm+IbTplZjOewOAxP0QIEQSyZOi/v/6W5ZUU2JOn9rHjyI896CvlB
	 z9reDrfW4mtdNvcxlOwRnPGUPaVO5WFBcTUVh0Ztirklq3OFVo1piUG8lJxzVjU/fF
	 LS0KQsdE4U2twpF6SqyoIV5Sb5xizpjwYFfLDE317xyks+33nFqwMpwCGPCaMvXLpv
	 IBkG6QRHE608I6LfoXQ1h8B1u5iykti3Wqg7G55yQEoLmEnn5Yv9bEmKLxevjzOozf
	 C+1Vp//S7QdssxUat202cgs1PegOYVtQZyRXpZeyXDKvMPqZ1xCWSLidFDre4Yv7Kt
	 6Ey8/VufGurqw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id D66056064B;
	Fri,  2 Oct 2026 21:32:04 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 948732E0
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 21:31:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7797A8144E
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 21:31:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id k6etP8TjahRZ for <u-boot@lists.u-boot-project.org>;
 Fri,  2 Oct 2026 21:31:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org A789981452
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=85.9.210.45
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790976685;
 b=QiOTdxVrFuYo8HEFHXTaALX7vbY4+yR+4azmMpo11Z/JL5N5izwhlNrbJw7yFvfCBBLO
 EwfefLSH0eLJl2ct8eqf6uP8Wjf6X83/QVlZNai6Q5+CTO36OrkULdZW4YdBvBwQx1uh0
 i2qejaRypW3R0EKBsaItLTRLqauIJUxuw1X7rMGNSCA41T0cEG5WXEIbCat4UZ6VYsk2c
 K/AmR4XrGUCC9OeCMl/I7CH4g19vlYFBVVPvbOKHMAeM/UiQGq7g+qnHXMw/iPDUCrw/8
 ndCqHJdUelwrmmMAk9g01Ps6a6fZE/9dRvAI17C99ulBde2AqTQwE2l+RhZ2KkEbskw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790976685;
 h=Received-SPF:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
 In-Reply-To:References:Feedback-ID:X-Pm-Message-ID:MIME-Version:
 Content-Type:Content-Transfer-Encoding;
 bh=+nzUmCh/xOwOnYLzD8k4DDXYdVCD9cDDSxtfM4YfXGY=;
 b=DH6AZDLvnbmxgBpB7EPl4O3XsEK6yPCGAgi8dbuWnv07d2wiPFmjTIl3wdo5hR9zWCxg
 Wz1pFfsUE4QWjBTJtmwYAbRExb4BPMbbZFEGk2nCYqhJr2BSMU7HNxUWY+ntRHCmAwoXi
 Jc85XYUhm12ONNtBZOZgzWWh8uDce6mQxHFyPa8X6KBdFur3HCOOyV20RRQ90smiWeDew
 /R1xpSS9ro7WqiayAALEktHnZ9ZOJNshCaZzwo9ej0R232v5IGtIW+YjIW370PCh3oe4o
 ul/RNmkddz+qlwE5QBCe0R3jiGakT56MadV954q02IpskycF70kvdRZPk3g+1aPnZuw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=protonmail.com; 
 dkim=pass header.d=protonmail.com header.i=@protonmail.com header.a=rsa-sha256
 header.s=protonmail3 header.b=nOPzFpOE; 
 arc=none smtp.remote-ip=85.9.210.45
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=85.9.210.45;
 helo=mail-06.mail-europe.com; envelope-from=davewk225@protonmail.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=protonmail.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com
 header.a=rsa-sha256 header.s=protonmail3 header.b=nOPzFpOE
Received: from mail-06.mail-europe.com (mail-06.mail-europe.com [85.9.210.45])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A789981452
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 21:31:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
 s=protonmail3; t=1790976679; x=1791235879;
 bh=+nzUmCh/xOwOnYLzD8k4DDXYdVCD9cDDSxtfM4YfXGY=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=nOPzFpOEQyfaLWHlkWd89+An6UWWmIeHj8Of4wTVGx5oflAyZl6pLskGtZaE0aBI1
 qeT5Cr0ICpVAK4cpcjwuxM0G0Ieb8/gui+F8NVrnEp7ukpqoK17vfde5XhpfPDAj9h
 AY/7kgu2uxBKdlFMoq/wkEReU69ZtQ46M3PDbN0S7UKPIFwJHvnUuN0fqxgez+yN1y
 tr0WGShPR1UU/u58mL47dMxQvCERMiIYDzChVX+A78NzE7b+EaRauKFPx/9JdMhnhi
 nE/KcoyAvp06prilDKETCOkcr0acPuTHOtD3chclw3xigiEDGMUIQNrKIbUfciDvAV
 Za/LpQF8k4kRQ==
Date: Fri, 02 Oct 2026 21:31:14 +0000
To: u-boot@lists.u-boot-project.org
From: Dave Klotz <DaveWK225@protonmail.com>
Cc: Huan Zhou <pericycle.cc@gmail.com>, Eric Chung <eric.chung@riscstar.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Yixun Lan <dlan@kernel.org>,
 Tom Rini <trini@konsulko.com>, u-boot-spacemit@groups.io
Subject: [PATCH 7/9] pci: spacemit: do not advertise ASPM L1
Message-ID: <da9405675d3b0527e90e4d59d81b3a7ec24d1075.1790975598.git.DaveWK225@protonmail.com>
In-Reply-To: <cover.1790975598.git.DaveWK225@protonmail.com>
References: <cover.1790975598.git.DaveWK225@protonmail.com>
Feedback-ID: 100562830:user:proton
X-Pm-Message-ID: 3a9a6a01023c0f670c18e1b29fa55f4ab7f545f4
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Fri, 02 Oct 2026 21:32:02 +0000
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

The root port advertises ASPM L1 support in its Link Capabilities, so
software that configures ASPM from what the port reports, such as an
EFI application or an operating system that does not reinitialise the
controller, may put the link into L1.

Linux's pcie-spacemit-k1 driver clears PCI_EXP_LNKCAP_ASPM_L1 at init,
as a workaround for errors reported on some NVMe drives. Do the same
before link training starts, so the port is set up as Linux sets it up.

Signed-off-by: Dave Klotz <DaveWK225@protonmail.com>
---
 drivers/pci/pcie_dw_spacemit.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/pci/pcie_dw_spacemit.c b/drivers/pci/pcie_dw_spacemit.=
c
index 6ac1d6bea4..3b5c2dc4e0 100644
--- a/drivers/pci/pcie_dw_spacemit.c
+++ b/drivers/pci/pcie_dw_spacemit.c
@@ -71,6 +71,12 @@ static void pcie_dw_configure(struct pcie_dw_spacemit *p=
ci)
=20
 =09dw_pcie_dbi_write_enable(&pci->dw, true);
=20
+=09/*
+=09 * Do not advertise ASPM L1: as Linux's driver notes, some NVMe drives
+=09 * report errors with it.
+=09 */
+=09clrbits_le32(cap + PCI_EXP_LNKCAP, PCI_EXP_LNKCAP_ASPM_L1);
+
 =09/*
 =09 * Keep the hardware's supported speeds unless the device tree limits
 =09 * them with "max-link-speed", as Linux's DesignWare core does.
--=20
2.55.0


