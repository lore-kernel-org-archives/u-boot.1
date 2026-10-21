Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 384D2606A31A
	for <u-boot@archiver.kernel.org>; Wed, 21 Oct 2026 12:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=WoaPc+ua
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0BBBB6081D;
	Wed, 21 Oct 2026 12:45:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aPqm7vLiwmr8; Wed, 21 Oct 2026 12:45:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org D13AD607F6
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792586744;
	b=BlLQclsCVXxuZXemlup8Hn14yU7ulh8I5tHiWhne66dV9dkaOk1tgRe3ezzJk3Aq+Iuf
	 mCV9Gis7pH2yvy2mrLlC8phkHINRSH/4FFll1mtdfv8enJ06vuSbivnklsVSfiGJq+FjS
	 0dgqV1+ZvkKJpm3TkXH4/FFt6V/YnzZG4sNACr0Z4lrVuXQOMFctUM+1Enr4rHrdomiK4
	 GucO55N4B5z7T6faoa0ocebKmULlslDDhYj7JJtTi4fha8ippSQytGZfu28N1vcWeNV7F
	 m5O0Ea1w1ANj2wj3PivKkeLBLstvE+gXiKjv/fKzqp4oiIT6hx6U8NToz/VzOO542gg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792586744;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Greylist:Received-SPF:Received:
	 Received:Received:From:Subject:Date:Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 CC:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=FIOBHGpQkGOhGkvYsGBEimFTch1pyQzEKhbPdJj1sec=;
	b=lzJxBRBwucEcy4UK5OoA3uGUVXbiQCWregQ8jWtFbVDp/IeJw5vHqGoOQiXSz3lyHTb9
	 3QyC6gLBLYm3fBVeCE5gMbKATqF2TZKdOLfW3j6XIgPBzr08ee+Om9Om6EqbNmUC80hlE
	 GljzhncTvjOciSsqz7O1q9O9ZhLsw5jN/H6D1BLJ52M86TbRub2FVp+5a1190KB1D59/G
	 jWm2NSX25e6TU4L3bCjC5l/SgniV3oX8vkI7talBjjyoWCGsmRxhBqMr1MKOANfbmvlKw
	 tTxv4NmQChMRtuPgoLXN+6Nl6045rHQIAIzHWybjXPi1B28blryXivDROJZ5YdK+kaw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792586744;
	bh=FIOBHGpQkGOhGkvYsGBEimFTch1pyQzEKhbPdJj1sec=;
	h=From:Subject:Date:To:CC:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=WoaPc+ua3iNde9lJuIcyJHzI0Z6wWXbXsI9fXfVwiljgEvLp01DQdR6iDEXGynjUH
	 NoMoPKgKEtYJvj3xUoE7POuuWa+9TqC2lHnwv/ZFInDtHmINefnk31mP6AHF9ln46t
	 jS1ZHD0fuH5h5t/YW37yBEsFT+6EgzZy/AqJvBulnyPhmrGp7s8KibImqQs2sYIjXi
	 qzooZiLxpQg7da4Jd+D5g4ulOzvbB33fGaciYvW2ZTwZ5LTepdlf4gDaTNoDHalaZv
	 Y/o6uXyyuXQRNxGhN6uZkhK8YXbrgE9bPRt8ywaEX1tyegsoS7YefQvQ5giWZ7Xttq
	 Mrr0KIIo6I1Nw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id D13AD607F6;
	Wed, 21 Oct 2026 12:45:43 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 7A48B2A8
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 06:39:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 6BCC44072E
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 06:39:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lh0Da3kO9fMW for <u-boot@lists.u-boot-project.org>;
 Wed, 21 Oct 2026 06:39:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 6BD2B4060C
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792564758;
 b=idFVT8IMoZM0B+4CI7cKQXM1JEbRULF2vFMbNfCypX71Pu0eiap4CnEwbk7M8kcMcGO8
 8eL6uZF9oteFUjGSNwnKPdEpZxq+IwmKoxPoQo55FZVTrSPQgsskblk4YcIImJgo5nCU9
 uEKpLpwYN6/tdXfWYsDhuAIwBxMk4zmAgCr32bdQShy1Ez01e7C7CWV5Goo59QIIwDI8/
 brJK6hwfEkqZUoFLX3K8c1g/VjaJt/g45q/KKzjUJxcMK1Oh45QvXcTkR/A6G3eFyvAaj
 1p/wqzWyDFV1xnH8TfcDTYDQ8DyTLkZaL+XmEBeeytDxsy9usK72RtQLbHQ0EEc+T0A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792564758;
 h=X-Greylist:Received-SPF:Received:Received:From:Subject:Date:
 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:
 X-B4-Tracking:X-Change-ID:To:CC:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=FIOBHGpQkGOhGkvYsGBEimFTch1pyQzEKhbPdJj1sec=;
 b=pkbe+b46etJz/QWtYNVA518b5TWqj7WQ0458rJXfQZ3OqlaNuHSHTPQrYt6LStGFAyfi
 PfdgEYcTTXAq1ikuInTplSenO0rLGLrXb2d3o64P3lsZPdDKHJEgJSKZ6szPbRvBH5yiq
 a4/U9wTM0fiJhoOJDAJxHS+gBRxX30+Hw+M6APDDIIWzaWT1xJpE+u5h1BODejtgZsvSu
 vzFZ1+VmJkOfdiAcwYNrs0XcT8oRxx/fVd3ykAgQETZnRUo9jmAFdX/A3glcVxdd0GL8x
 6wUDUS+AQX17P7nRc2x0ChZZnhL9sid8iRyZjSdGBJybBuniCSOIFv5ED214y5M9oOw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=aspeedtech.com;
 arc=none smtp.remote-ip=211.20.114.72
X-Greylist: delayed 304 seconds by postgrey-1.37 at util1.osuosl.org;
 Wed, 21 Oct 2026 06:39:17 UTC
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=aspeedtech.com
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=211.20.114.72;
 helo=twmbx01.aspeedtech.com; envelope-from=jacky_chou@aspeedtech.com;
 receiver=<UNKNOWN> 
Received: from twmbx01.aspeedtech.com (mail.aspeedtech.com [211.20.114.72])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 6BD2B4060C
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 06:39:16 +0000 (UTC)
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Wed, 21 Oct
 2026 14:34:09 +0800
Received: from [127.0.1.1] (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Wed, 21 Oct 2026 14:34:09 +0800
From: Jacky Chou <jacky_chou@aspeedtech.com>
Subject: [PATCH 0/6] net: ftgmac100: Add RGMII delay support
Date: Wed, 21 Oct 2026 14:34:03 +0800
Message-ID: <20261021-ftgmac-rgmii-delay-v1-0-fce405523118@aspeedtech.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANtc2GoC/x3MQQqAIBBA0avErBtQFy26SrSYdLSBtNCIQrp70
 vIt/q9QOAsXGLsKmS8psqcG3XdgV0qBUVwzGGUGrYxGf4ZIFnOIIuh4owc1EQ/eq8UxQQuPzF7
 ufzrN7/sBwK+yHmQAAAA=
X-Change-ID: 20261021-ftgmac-rgmii-delay-1aae6ff0bdea
To: Aspeed BMC SW team <BMC-SW@aspeedtech.com>, Joel Stanley <joel@jms.id.au>, 
 <u-boot@lists.u-boot-project.org>
CC: Jerome Forissier <jerome.forissier@arm.com>, Tom Rini
 <trini@konsulko.com>, Ryan Chen <ryan_chen@aspeedtech.com>, Chia-Wei Wang
 <chiawei_wang@aspeedtech.com>, Quentin Schulz <quentin.schulz@cherry.de>,
 David Lechner <dlechner@baylibre.com>, Julien Stephan
 <jstephan@baylibre.com>, Johan Jonker <jbx6244@gmail.com>, Peter Robinson
 <pbrobinson@gmail.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 "Jacky Chou" <jacky_chou@aspeedtech.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792564449; l=2638;
 i=jacky_chou@aspeedtech.com; s=20251031; h=from:subject:message-id;
 bh=zNwaOC9rrv0qn3s+B/Wq8KC0rbi3PmavEkWJMUR+hZg=;
 b=r/O6rZpWq98dI7wW34r+efOseHTfvx46T4cclTZQnB53+ba0WIXgLrlbqDbOtZCOfITKPOgIZ
 kuECLm0n4moDA2w6EQeTeNHR3/KgnHYCjnTMNU9twcZNiID8uVffXPp
X-Developer-Key: i=jacky_chou@aspeedtech.com; a=ed25519;
 pk=8XBx7KFM1drEsfCXTH9QC2lbMlGU4XwJTA6Jt9Mabdo=
X-Mailman-Approved-At: Wed, 21 Oct 2026 12:45:42 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-16.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This series adds support for configuring the RGMII TX/RX internal
clock delay on the FTGMAC100 driver via the tx-internal-delay-ps and
rx-internal-delay-ps devicetree properties, matching the convention
used by other Ethernet drivers for RGMII PHY delay configuration.

On Aspeed AST2600 and AST2700, this delay is implemented as a
per-MAC programmable delay chain in the SCU, so it needs to be
configured by the MAC driver rather than relying solely on the PHY
or the "phy-mode" strapping. The two properties are opt-in: the
clock driver already programs a default delay into these same SCU
registers, so unless a board's devicetree provides at least one of
the two properties, the driver leaves the delay chain untouched
instead of forcing it to zero and regressing boards that are not
using this new MAC-side delay configuration.

Patch 1 adds support for AST2600, and patch 2 extends it to AST2700.
Patches 3-5 wire the feature up in the devicetree: patch 3 and 5 add
the "aspeed,scu" phandle the driver needs to reach the SCU on AST2600
and AST2700 respectively, and patch 4 switches ast2600-evb.dts to use
it (phy-mode = "rgmii-id" with 0 ps MAC-side delay on all four MACs,
replacing the unused legacy mac*-clk-delay properties under &scu).

Patch 6 is unrelated to the MAC-side delay added by this series: it
sets the TI DP83867 PHY's own internal delay explicitly for mac1 on
the DDR5 variant of the AST2700 EVB, documenting a value that matches
the driver's existing default instead of relying on it implicitly.
It is included here because it was found while bringing this series
up on that board.

Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>
---
Jacky Chou (6):
      net: ftgmac100: Add RGMII delay support for AST2600
      net: ftgmac100: Add RGMII delay support for AST2700
      arm: dts: ast2600: add aspeed,scu property for MAC
      arm: dts: ast2600-evb: Configure RGMII delay for MAC
      arm: dts: ast2700: add aspeed,scu property for MAC
      arm: dts: ast2700-evb: Set TI DP83867 internal delay for mac1 PHY

 arch/arm/dts/ast2600-evb.dts |  33 +++---
 arch/arm/dts/ast2600.dtsi    |   4 +
 arch/arm/dts/ast2700-evb.dts |   4 +
 arch/arm/dts/ast2700.dtsi    |   3 +
 drivers/net/Kconfig          |   1 +
 drivers/net/ftgmac100.c      | 239 ++++++++++++++++++++++++++++++++++++++++---
 drivers/net/ftgmac100.h      |  33 ++++++
 7 files changed, 283 insertions(+), 34 deletions(-)
---
base-commit: 62c9805d8d57cad407f0295879cc9a6182da464a
change-id: 20261021-ftgmac-rgmii-delay-1aae6ff0bdea

Best regards,
-- 
Jacky Chou <jacky_chou@aspeedtech.com>

