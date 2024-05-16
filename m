Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 735FCC25B78
	for <u-boot@archiver.kernel.org>; Thu, 16 May 2024 22:17:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EF4928848B;
	Fri, 17 May 2024 00:16:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=flygoat.com header.i=@flygoat.com header.b="irWu4sYj";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="k0nQq/Es";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3DECE88481; Fri, 17 May 2024 00:16:49 +0200 (CEST)
Received: from fhigh2-smtp.messagingengine.com
 (fhigh2-smtp.messagingengine.com [103.168.172.153])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D5F328847A
 for <u-boot@lists.denx.de>; Fri, 17 May 2024 00:16:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jiaxun.yang@flygoat.com
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
 by mailfhigh.nyi.internal (Postfix) with ESMTP id F04B91140184;
 Thu, 16 May 2024 18:16:45 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute1.internal (MEProxy); Thu, 16 May 2024 18:16:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1715897805;
 x=1715984205; bh=kYWxF9QMnStIYpC5yIe1GHvig56tidVm3UveflL5Krc=; b=
 irWu4sYj2dMZUWVa7VeOuvNSUWDk4b87YiD2LINC6e4IrRPscuMFcqDLSqxTHlNp
 fXvqWyOH+YaIEo9KiN9xF5gJUK9H/qfjuq0nD70OC11oM/hVIpH4VQEynBorsIT1
 AW0h5YRD3UGJPKql/pCskAsqxtXgQbWQxLP1H0KQDT1HoOb/zsVS2+JQCkiAVcN+
 I+Cdbe/lek6xPrcQvq2/gHtUsHimrRIMQrTl0T8R2c5DkpBLZe7LlMdRn7x9Cygu
 xYrGV8S45BKmVnsVdCjf/AvDBZlK+N/BO7fRKGOyswKM+a94YpXzeh1d6ZuwRbHO
 X3Frt7pMuzaDwbGk4NFabw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1715897805; x=
 1715984205; bh=kYWxF9QMnStIYpC5yIe1GHvig56tidVm3UveflL5Krc=; b=k
 0nQq/Esa42oXDBuX13XkCv5twNP9LfxT4icMdm9TgNOi6k3LBw1+fT2s1iCIfrm0
 qwK65ht4418KazZNAnlhJV/iYku11ufIPtAYCClzovFPzddA49pl8iGHaUUhq81Q
 JCs9XKUc+gCVKDUkoBIFsvwy/xRQsmwWsoeGGPFlGuriI8BwV3I/ag6IARtoom9J
 wZK7Wp0L6ytYS6YY1DgJ+ZKWLrgcKN5lCGEKDLkbNMsfR11WEHvrIOBoqcP3yNsa
 /o+bvkMslDDOBow0RnHTXFEEZAnbFP5wKhQOLYiOUSkKLG9tXwcHPR/ZiTqkYmxc
 H3SjNe2KCbb7NXcefqZNg==
X-ME-Sender: <xms:zYVGZo-LtCkd1hR09IXK2YttliHv41E10AyMNII_jxFZ2fGn7_A9GA>
 <xme:zYVGZgsCDOlGgLi2IPaS0G-n3mulb2qcVe0a4DRIgbujIVsLQ49kr6A1V01H2b7xL
 GF4ogSdfd1ujcYj-u8>
X-ME-Received: <xmr:zYVGZuAYd2fpddLCfJC3nJN_FpxSNPgW7NpAn3xR_-WPC6rQYYjH6_w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdehvddgtdeiucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpeflihgr
 gihunhcujggrnhhguceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomheqne
 cuggftrfgrthhtvghrnhepvdekiefhfeevkeeuveetfeelffekgedugefhtdduudeghfeu
 veegffegudekjeelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
 hfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomh
X-ME-Proxy: <xmx:zYVGZodDcoESnAVNapUmkJ7CXxdohpb83t35msE-UaGHFfz3rLz1mQ>
 <xmx:zYVGZtPOCVVrOaOUP4a2nDvfuMGRzIz7MFSeldIXm9kKZYz3L72Xxw>
 <xmx:zYVGZik-aSqGI8rsqgiH5AaILK8LIvi9Itnl8EtkzfzC_5VYYJGUWQ>
 <xmx:zYVGZvveEev191t69VC1ku4lFGMfordYEdN36c22BdnDuG2BcjaYGw>
 <xmx:zYVGZgpUyxjdN2LUBEPW9W9Euu8k_bodyd0pf1zW5Y6LzFLZpSXUpnFW>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 May 2024 18:16:44 -0400 (EDT)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Thu, 16 May 2024 23:16:42 +0100
Subject: [PATCH 2/6] video: Add gitignore for u_boot_logo.S
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240516-rework-video-format-v1-2-f69822b742a3@flygoat.com>
References: <20240516-rework-video-format-v1-0-f69822b742a3@flygoat.com>
In-Reply-To: <20240516-rework-video-format-v1-0-f69822b742a3@flygoat.com>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Heiko Schocher <hs@denx.de>, 
 Marcel Ziswiler <marcel.ziswiler@toradex.com>, 
 Anatolij Gustschin <agust@denx.de>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Simon Glass <sjg@chromium.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=401;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=tcd/wXsBWhX/O8cZaJ86SBcB0LzNjhFS4SNjPeb1KY0=;
 b=owGbwMvMwCHmXMhTe71c8zDjabUkhjS31tNh84W4W9vF3sjOq4pvfuAUcKRu56JHn1ur5jcvn
 vkjP6Wno5SFQYyDQVZMkSVEQKlvQ+PFBdcfZP2BmcPKBDKEgYtTACYy8QAjwzyb03Zv50nP+bAx
 Ieb69Jd+Lkz8qYLL6pzf7L3kuWW7iRsjw/pFShWLDjy2v8z1NGeVbGfdlzeNk7bXuulY9il3Oc9
 VZgEA
X-Developer-Key: i=jiaxun.yang@flygoat.com; a=openpgp;
 fpr=980379BEFEBFBF477EA04EF9C111949073FC0F67
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

We don't want this generated file to be tracked by git.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 drivers/video/.gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/video/.gitignore b/drivers/video/.gitignore
new file mode 100644
index 000000000000..163c491c7630
--- /dev/null
+++ b/drivers/video/.gitignore
@@ -0,0 +1 @@
+u_boot_logo.S

-- 
2.34.1

