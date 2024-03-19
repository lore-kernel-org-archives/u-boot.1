Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A274C54E5D
	for <u-boot@archiver.kernel.org>; Tue, 19 Mar 2024 12:12:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2170C87E96;
	Tue, 19 Mar 2024 13:12:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=micro-green.social
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=micro-green.social header.i=info@micro-green.social header.b="RFfj9pfD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 98DE98751B; Tue, 19 Mar 2024 09:09:04 +0100 (CET)
Received: from janus.micro-green.social (unknown [38.123.137.175])
 by phobos.denx.de (Postfix) with ESMTP id 98182869F7
 for <u-boot@lists.denx.de>; Tue, 19 Mar 2024 09:09:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=micro-green.social
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=1876-513-179512-397-u+2Dboot=lists.denx.de@mail.micro-green.social
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; s=k1; d=micro-green.social;
 h=Mime-Version:Content-Type:Date:From:Reply-To:Subject:To:Message-ID;
 i=info@micro-green.social; bh=gP9OfPL6KG0ZE76H4n2++SFdY3E=;
 b=RFfj9pfDnsoKM4cNUoqcKC79RdmbWiL+17zqmMOoGQ7K4JqshxwgA/mQtkCu/YF4Ci8165/CN7zl
 VS53p757TUvROz3eVoQlJf6iJ4lnhJ3aq3Zn1K4QBXWJsbRtO0OvoSE+/1Ya0pE0h6a+3h9SyY9j
 wonONeNGwpWhj5HsZWS1O0tBCuwKu3KsY48kDb+i/dXgv7j6lSpJ6nf6LuEs3tiOLVgALjWDFIUz
 saT0FGQLdfCxDXc4wPUAw11a/EOhka1BQyfydEGu4rB9Gm6G1bvqlH+4uCwHfweCRXkkuG9KO26d
 yzvyGYbkKIJzSZdZEnlid3F+dgmb+m45l8V58A==
DomainKey-Signature: a=rsa-sha1; c=nofws; q=dns; s=k1; d=micro-green.social;
 b=TbOBPKbH+1dYoVvS84JUu6oiSrtvPzHEPPBnAN2XCmwgLh1iXCg+cZuWXqSAbLjoWsFqAkw3a237
 AkVX2ovVL9TMFub1f33rQ3Ln98+CWNDBtGjYJAG1oflne0oRprmWTA+WN8MQfQr6N6dItEQmcbTE
 RR2TaL9ABYfo2P+lh1sQAzeORZXe5zTx9pOAaiAZ37LnEm6KUjQ647i6f5OslcBEuw/nDU1HWlej
 EZX2EwYIENniMmut7WNhTloCds+xPcSv0Qi+R7pyZaWilRDjuyLl93Tij9rawStN52MWdCQEwD2V
 fezL1bBqiLPvIgmSfFSz+CPDik4jyGFylYevoQ==;
Mime-Version: 1.0
Date: Tue, 19 Mar 2024 08:08:57 +0000
From: "Power Outlets" <info@micro-green.social>
Subject: MagicOutlet isn’t just another extension cord
To: <u-boot@lists.denx.de>
Message-ID: <0lq7sov2fvh8s2a7-vn0w33dpo4lvyml0-2bd38@micro-green.social>
X-Mailman-Approved-At: Tue, 19 Mar 2024 13:12:10 +0100
Content-Type: text/plain;
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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
Reply-To: Power Outlets <support@micro-green.social>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Content-Transfer-Encoding: 8bit
