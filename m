Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84EFBD5CCAF
	for <u-boot@archiver.kernel.org>; Wed, 30 Oct 2024 14:24:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 24EF888FD2;
	Wed, 30 Oct 2024 15:24:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="UhZrg0B9";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="ulqjCY1p";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1347F88EDE; Wed, 30 Oct 2024 15:24:16 +0100 (CET)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org
 [IPv6:2001:67c:2050:0:465::103])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 33C5C88F47
 for <u-boot@lists.denx.de>; Wed, 30 Oct 2024 15:24:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4XdqBQ0LW9z9sbs;
 Wed, 30 Oct 2024 15:24:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1730298254;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2E9lZMPS5fWiSowqkMUwqrMjYbdimCmoCW4Ev6Eq9I8=;
 b=UhZrg0B9QpAmqDqDSKSRRuYiYAZjoENMZQBE57TuBf6It80AKUL2FbgQAehaLI0Nxs0OHw
 mFBP45eQB9rghyZJ1nxhBI3wqa/MBiYsGmA1GP+MQV2PCZDwNqVh1t1rQXzpddHFM54lzh
 I/l3jNY+ELduHxFoi/S33BWF46EtOusGqzC3wkwko1+8tMTk/vrShNXKc3Nu7RTM375xnA
 b9m/8dirB8GuvMWbK2Sm/6/Pp4LfI7LVfAdFyI93VAYpxZDvvGY0k7SpuDGCpEzVPkry0t
 7MvrwUZNomP4bg/C0XXKeP5RQixzVI86GJSiY4STOQyFrlFiQry8LTUgJUlpKw==
Message-ID: <775a1bd6-a888-4365-abb4-8c281cf7d43d@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1730298252;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2E9lZMPS5fWiSowqkMUwqrMjYbdimCmoCW4Ev6Eq9I8=;
 b=ulqjCY1pqLGNWDwwiGvIVuXGZZciFToKFWVKxmM/dbTaNuKZUbpOUxiIF2ufI4BUA1zTiq
 fMKi9keUX+6ZXVd3dTdMfYUbhfChJVQCyQGpFas7JLI3m4MLL/iq/7PeuPwqJDDPv1OH+E
 Q47L6Xu0EuRYW7RUeGsQEKTOyELkvPPd9pwXcOBnLU1JRNm/q/2RZ4wSi+uTzbc6TO+ems
 o3mXwllywEh2du9mXe6uEbde1kut0dYn7/+9e0t397uIdxtU/dlZxkJXi8N7uwWiH5sLEg
 VOgLf6wndMEz4/4cg6kc9ildhm5st97WxHTfDRfpWezmBUVVByx7UWCeFnviXQ==
Date: Wed, 30 Oct 2024 15:23:52 +0100
MIME-Version: 1.0
Subject: Re: [PATCH 2/2] dt-bindings: Drop unused RZ/G2L devicetree bindings
To: Paul Barker <paul.barker.ct@bp.renesas.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20241030103234.438-1-paul.barker.ct@bp.renesas.com>
 <20241030103234.438-2-paul.barker.ct@bp.renesas.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20241030103234.438-2-paul.barker.ct@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 7309609dd104d4d47e9
X-MBO-RS-META: 3n8yngtr5fwctn11ijkyp93734nazf94
X-Rspamd-Queue-Id: 4XdqBQ0LW9z9sbs
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

On 10/30/24 11:32 AM, Paul Barker wrote:
> We are now using the dts/upstream subtree for the RZ/G2L SoC family.

That's great news, but ... what does this commit do ?

It would be good to at least include "Drop unused headers" in the commit 
message.
