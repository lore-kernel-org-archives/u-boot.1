Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84ED7CD6E56
	for <u-boot@archiver.kernel.org>; Mon,  1 Jun 2026 12:16:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A633A84A52;
	Mon,  1 Jun 2026 14:07:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=mobileye.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="key not found in DNS" (0-bit key; unprotected) header.d=mobileye.com header.i=@mobileye.com header.b="VzYca935";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CF03E84881; Mon,  1 Jun 2026 13:28:00 +0200 (CEST)
Received: from esa2.hc555-34.eu.iphmx.com (esa2.hc555-34.eu.iphmx.com
 [23.90.104.147])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BE36B83EF9
 for <u-boot@lists.denx.de>; Mon,  1 Jun 2026 13:27:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none)
 header.from=mobileye.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raz.benyehuda@mobileye.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=mobileye.com; i=@mobileye.com; q=dns/txt; s=MoEyIP;
 t=1780313279; x=1811849279;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=AoCWZ8DrNFzXUZrH7YjXpfsOdIxLGa5OzZvFNdayeMQ=;
 b=VzYca935kJsxUeq46FBcNqgBdYZqRAWOUsK/ZVm/72RNf1hN4TG1aK7l
 sjO/Vu2XmqF3XnTOvG91mh5XMn3YExSBbEXfh7TH0ZdSI9HHHJMjqv3Ev
 dQo/OPJ0BxG9JyZW1cn8meUDnFCVxgfQcJzZ6rn9i+0HDNzCwNazA2Hrr
 KLhPTp2cdIBmjXFsNo9lnPR3YZy6eMBAlBpoCXuCbBz1/hDH6TFgcRSnx
 P0H7KI/rbKqSGeB81MhXtNaBDPzvRpxDAmmwBP+O/0TEl/V1rQ8JUfrHR
 40KYewhy5jT7qjim8mnPNtr37TB04378J7F/UYjLTAAaRv9/6VLyROR9S w==;
X-CSE-ConnectionGUID: Kaye1TUaSqeEK/V2oo5/ZA==
X-CSE-MsgGUID: OmFEfzkQRgm4hQmIrCEr0w==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from unknown (HELO ces02_data.me-corp.lan) ([146.255.191.134])
 by esa2.hc555-34.eu.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Jun 2026 14:27:58 +0300
X-CSE-ConnectionGUID: evdMtNvdRSqSnfFu+8jCcw==
X-CSE-MsgGUID: XOH8BwwcSt2Ql2FwD2nIAw==
Received: from unknown (HELO epgd041.me-corp.lan) ([10.154.54.3])
 by ces02_data.me-corp.lan with SMTP; 01 Jun 2026 14:32:41 +0300
Received: by epgd041.me-corp.lan (sSMTP sendmail emulation);
 Mon, 01 Jun 2026 14:27:56 +0300
From: Raz Ben Yehuda <raz.benyehuda@mobileye.com>
To: u-boot@lists.denx.de
Cc: Raz Ben Yehuda <raz.benyehuda@mobileye.com>
Subject: [PATCH 5/5] **Cover Letter for ufs-tool**
Date: Mon,  1 Jun 2026 14:27:54 +0300
Message-ID: <20260601112754.2337900-1-raz.benyehuda@mobileye.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 01 Jun 2026 14:07:04 +0200
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

This patch series adds support in U-Boot for interacting
with UFS devices. It provides the ability to
query and configure UFS device parameters.
It is customary to configure UFS logical units (LUNs)
outside the general-purpose operating system,
as storage devices may be removed or replaced,
potentially affecting system behavior.

This tool has been tested with UFS devices from Micron and Western Digital.

Signed-off-by: Raz Ben Yehuda <raz.benyehuda@mobileye.com>

--- b4-submit-tracking ---
# This section is used internally by b4 prep for tracking purposes.
{
  "series": {
    "revision": 1,
    "change-id": "20260601-ufs-tool-030d47d5df42",
    "prefixes": [],
    "presubject": ""
  }
}
-- 
2.43.0

