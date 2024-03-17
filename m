Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93995C54E67
	for <u-boot@archiver.kernel.org>; Sun, 17 Mar 2024 11:34:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CA34687A00;
	Sun, 17 Mar 2024 12:34:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=jannau.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=jannau.net header.i=@jannau.net header.b="mWIUxPRA";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="A1bjxnFl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0C10787EE3; Sun, 17 Mar 2024 12:34:37 +0100 (CET)
Received: from wfhigh3-smtp.messagingengine.com
 (wfhigh3-smtp.messagingengine.com [64.147.123.154])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BBE5487A00
 for <u-boot@lists.denx.de>; Sun, 17 Mar 2024 12:34:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=jannau.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=j@jannau.net
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
 by mailfhigh.west.internal (Postfix) with ESMTP id 9A77D180007D;
 Sun, 17 Mar 2024 07:34:26 -0400 (EDT)
Received: from imap53 ([10.202.2.103])
 by compute1.internal (MEProxy); Sun, 17 Mar 2024 07:34:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jannau.net; h=cc
 :cc:content-type:content-type:date:date:from:from:in-reply-to
 :in-reply-to:message-id:mime-version:references:reply-to:subject
 :subject:to:to; s=fm3; t=1710675266; x=1710761666; bh=8q1IuS1rzE
 +FUa/Y3eDENh4V2KS1vdjIbKQyP5jkXCY=; b=mWIUxPRA9UFH58GSdaIJqOsxKP
 EidFWI8k+IArPKs3W7AZ7hyX6A1nq9oujAtFmwDXzI10AVBaB6NSHauhxDUOxKw9
 dSa7RBn6Z9fUJnYyd/EdKbuwEyewqw1hiIpU6c64hEgX1cwv5YHuF9QueLOmOVX8
 wQXQy8U6L7oZa9ODNkG0T6UyZK9ESDi7guOSRdZAjlUir3gnJnrnwAyQ1lGQdosp
 qU27NVw8tTsFqlQaEw7MYtykQim+ovUSF6HZ/mlrq5XI6xQpmKJajRe6I5r2YBaz
 vvX0UeQTvSMPyzczYxHOJN1I4/XdQ+ejBtqa7quc7iMV7t5EWDyatIfc85Zg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm2; t=1710675266; x=1710761666; bh=8q1IuS1rzE+FUa/Y3eDENh4V2KS1
 vdjIbKQyP5jkXCY=; b=A1bjxnFlGJ77dKElBySeNkh9HLxllHimRhRQNIHvNKmU
 YChygTNZFEjX6/NyGJ4kyOnegbH3FwHqIjGeyTepcr3tXDxpn2HdyGyP65WB/i1v
 E2FMxfUIsigmcOS8NpO2vCor04QFSyMXWm4y1I+HjCUzk00/l32bu2OjqqVGtDpR
 hqsPOcUCSwcMAP4fVPPWCJD0gKedG/rhXkjTjt+QtWROBUGhoh8GCS7AsEABtWTw
 GDjI9f/BbNVGi0UmNgr2YWqmAKpGODV8K9xlZS/jIVqAVE4YsQ9EUDYNkTfoRn4R
 cHmeCP6WgPnNzXrUqPmljIC8TDzTuTXWJhBC2XczZA==
X-ME-Sender: <xms:QdX2ZTO0XpyqKXvw3DqRZUXmehcJthZzhaVOiJFh14k0EA_lAgXKFQ>
 <xme:QdX2Zd-nMkv0ih02J0kYWG2kV8vGhmlYqFfpTjioELeL1OdYMtXexYn6hC-ZTbH9Q
 DxNjXiVeJB2cfkkzzg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrkeehgddtiecutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdflrghn
 nhgvucfirhhunhgruhdfuceojhesjhgrnhhnrghurdhnvghtqeenucggtffrrghtthgvrh
 hnpefhheeiveffvddtteeugfeuudekfeetudethffhfefhfefhkeeuhfeffeetjefhieen
 ucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenuc
 frrghrrghmpehmrghilhhfrhhomhepjhesjhgrnhhnrghurdhnvght
X-ME-Proxy: <xmx:QdX2ZSQsWKI0ElxclgkoNpLB1OCnj4wsQ17Qt0p_4cO-LkKmMfWvGQ>
 <xmx:QdX2ZXuPRoWN7yny3y4bZszqKRTV-UmgrSJIUzlt9R1okWZHCDWlUQ>
 <xmx:QdX2Zbddm096FAZ_dWbcucesR6hhLXJUBXGmvtTqhJDjcOszEfCCrg>
 <xmx:QdX2ZT3t8xKhNeayjOyA9T5FcJ1Ylmwe4YZ9sqh0B-tnU5XOjDAQDA>
 <xmx:QtX2ZdvnoSDfEg3856NckbiWJW7sIswXbkdn48GFYfq_pYHuqgzFTG-VdC4>
Feedback-ID: i47b949f6:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
 id C6F7E36400AB; Sun, 17 Mar 2024 07:34:25 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-300-gdee1775a43-fm-20240315.001-gdee1775a
MIME-Version: 1.0
Message-Id: <5faec4e0-c375-4bc1-9eda-ca7da14eea3b@app.fastmail.com>
In-Reply-To: <20240317-asahi-keyboards-v2-4-d3f4b8384f68@jannau.net>
References: <20240317-asahi-keyboards-v2-0-d3f4b8384f68@jannau.net>
 <20240317-asahi-keyboards-v2-4-d3f4b8384f68@jannau.net>
Date: Sun, 17 Mar 2024 12:34:05 +0100
From: "Janne Grunau" <j@jannau.net>
To: "Bin Meng" <bmeng.cn@gmail.com>, "Marek Vasut" <marex@denx.de>,
 "Tom Rini" <trini@konsulko.com>, "Simon Glass" <sjg@chromium.org>,
 "Joe Hershberger" <joe.hershberger@ni.com>
Cc: u-boot@lists.denx.de, asahi@lists.linux.dev
Subject: Re: [PATCH v2 4/6] usb: Add environment based device blocklist
Content-Type: text/plain
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

Hej,

On Sun, Mar 17, 2024, at 12:07, Janne Grunau via B4 Relay wrote:
> From: Janne Grunau <j@jannau.net>
>
> Add the environment variable "usb_blocklist" to prevent USB devices
> listed in it from being used. This allows to ignore devices which
> trigger bugs in u-boot's USB stack or are undesirable for other reasons.
> Devices emulating keyboards are one example. U-boot currently supports
> only one USB keyboard device. Most commonly, people run into this with
> Yubikeys, so let's ignore those in the default environment.
>
> Based on previous USB keyboard specific patches for the same purpose.
>
> Link: 
> https://lore.kernel.org/u-boot/7ab604fb-0fec-4f5e-8708-7a3a7e2cb568@denx.de/
> Signed-off-by: Janne Grunau <j@jannau.net>
> ---
>  common/usb.c              | 56 
> +++++++++++++++++++++++++++++++++++++++++++++++
>  doc/usage/environment.rst | 12 ++++++++++
>  include/env_default.h     | 11 ++++++++++
>  3 files changed, 79 insertions(+)
>
> diff --git a/common/usb.c b/common/usb.c
> index 836506dcd9..73af5be066 100644
> --- a/common/usb.c
> +++ b/common/usb.c
> @@ -1084,6 +1084,57 @@ static int usb_prepare_device(struct usb_device 
> *dev, int addr, bool do_read,
>  	return 0;
>  }
> 
> +static int usb_blocklist_parse_error(const char *blocklist, size_t pos)
> +{
> +	printf("usb_blocklist parse error at char %zu in \"%s\"\n", pos,
> +	       blocklist);
> +	return 0;
> +}
> +
> +static int usb_device_is_blocked(u16 id_vendor, u16 id_product)
> +{
> +	ulong vid, pid;
> +	char *end;
> +	const char *block_str = env_get("usb_blocklist");
> +	const char *cur = block_str;
> +
> +	/* parse "usb_blocklist" strictly */
> +	while (cur && cur[0] != '\0') {
> +		vid = simple_strtoul(cur, &end, 0);
> +		if (cur == end || end[0] != ':')
> +			return usb_blocklist_parse_error(block_str,
> +							 cur - block_str);
> +
> +		cur = end + 1;
> +		pid = simple_strtoul(cur, &end, 0);
> +		if (cur == end && end[0] != '*')
> +			return usb_blocklist_parse_error(block_str,
> +							 cur - block_str);
> +
> +		if (end[0] == '*') {
> +			/* use out of range idProduct as wildcard indication */
> +			pid = U16_MAX + 1;
> +			end++;
> +		}
> +		if (end[0] != ',' && end[0] != '\0')
> +			return usb_blocklist_parse_error(block_str,
> +							 cur - block_str);
> +
> +		if (id_vendor == vid && (pid > U16_MAX || id_product == pid)) {
> +			printf("Ignoring USB device 0x%x:0x%x\n",id_vendor,
> +			      id_product);

this is a leftover from testing, already removed locally

Janne
