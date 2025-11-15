Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74AEECEB2DA
	for <u-boot@archiver.kernel.org>; Sat, 15 Nov 2025 16:31:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B337183A3A;
	Sat, 15 Nov 2025 17:31:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="bG7XltWE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A7BE483A3B; Sat, 15 Nov 2025 17:31:22 +0100 (CET)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org
 [IPv6:2001:67c:2050:0:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DA83783A35
 for <u-boot@lists.denx.de>; Sat, 15 Nov 2025 17:31:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4d7zz96z9Vz9ttB;
 Sat, 15 Nov 2025 17:31:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1763224278;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=017hzbI/cdmOGHld/A4t5Z6oFgx/PwyekuPe1hWIgQk=;
 b=bG7XltWEAtrymTQEKHSBQxnVG/zSTG/RPzPm6Ue6T2JzhlpVaBMebYKVbVWkjyHzz4d0ef
 0HxHGDSwqRUFij6tWqufejJUK5HEak3KVXnxH3bVi4IUsBQUb8K+yWs0pF5EqU0ZX4DNtq
 d5kjpjEsOIQi0JMgA5+fbQ/FEzhkZtse9nlbmINqe7ks2YItvDhd2RGM+lsDS9VlAC/Ap7
 rIDbgZKDt2W5os8ZlZWTU8pwhAegbfworpEmo9pqdP+9GdTTLthwxAnMA+HW1OIUPs0m+d
 0QTl/0KgqKkUFdVc+cmSIw2wVPXhfeoQpdPUPBIifmm+QbUNCB1H0jFG/y70Wg==
Message-ID: <6d9941c2-69b6-453a-b8a4-45f2d78daa60@mailbox.org>
Date: Sat, 15 Nov 2025 17:31:02 +0100
MIME-Version: 1.0
Subject: Re: [PATCH v2 1/1] usb: USB_EHCI_PCI depends on PCI
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Alice Guo <alice.guo@nxp.com>, Fabio Estevam <festevam@gmail.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>, u-boot@lists.denx.de
References: <20251115095820.11206-1-heinrich.schuchardt@canonical.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20251115095820.11206-1-heinrich.schuchardt@canonical.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 8583dfa64fcc4bd9828
X-MBO-RS-META: jcf7w53kdwhdytibsspqrgamd8pdrapq
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

On 11/15/25 10:58 AM, Heinrich Schuchardt wrote:
> CONFIG_USB_EHCI_PCI cannot work without CONFIG_PCI.
> 
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Reviewed-by: Marek Vasut <marek.vasut@mailbox.org>

Thanks !

-- 
Best regards,
Marek Vasut

