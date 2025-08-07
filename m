Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD62EC87FCF
	for <u-boot@archiver.kernel.org>; Thu,  7 Aug 2025 10:28:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1571A83C61;
	Thu,  7 Aug 2025 12:28:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1754562537;
	bh=VUCD6oEg9i38DAfufMKTTeVWsIFPFFlWMq6bKlBc6CY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=iNK6ovLFpQ1XX2rP3R+i3KXa+77xco1cy0pIqzTNr4x9TJAWwEGEyIhkGCrEtOeFy
	 e6aZ3szCxUc9oip6XsvQA517tcdR1e9ynUJU8nohby/cF+/YwEmoeDVWz0vKSmWOut
	 BzE1hHtnBlPp7MUTepskddh71CHasgvcdbo7DdXzqIxM/um5dnc5CNgpJXdjG3ssJN
	 9ZNjbOfUt0tRLZFFZsLBfj9lwI6RhpXILcIPJdnjte7k1SqclxLf54C/Ylq48Wr1o+
	 zrmao50/N4h+iDPZEUoxYAA7b1f0fiJhYglzxZCDDgDVEjauADwo4icU93RaV+bNxL
	 0MmZDKASJ2NZw==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0B958843E2; Thu,  7 Aug 2025 12:28:56 +0200 (CEST)
Received: from mx.denx.de (mx.denx.de
 [IPv6:2a03:4000:64:cc:545d:19ff:fe05:8172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 990E383C53
 for <u-boot@lists.denx.de>; Thu,  7 Aug 2025 12:28:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=pro@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="a9rVjLFg"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 0C5921038C12B; 
 Thu,  7 Aug 2025 12:28:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1754562533; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 in-reply-to:references; bh=VUCD6oEg9i38DAfufMKTTeVWsIFPFFlWMq6bKlBc6CY=;
 b=a9rVjLFggSgZZZg5CKnH6265XODhsL/XNQy1geFHvjs6qE2ZJQ4lfVbZhfSi8nuawOxmMh
 3Abdg+C/9E3Wh7lDQqZPmXb+5U3+JIp7S6J/3jJh2A5EIm0ueRtUiZDVjxcolYpg+WvZK0
 +0SPbxBwzuZcAoyH+PChE6/z0ytIyTEUx4eQM0uu67NkFyYryoJAQVmO7KdAMu0KwJBpoF
 RU5MUW2lh+s804hPsFjgThOg8tu02ONk8zpwyj9BgcHvXfbL4PEVAzCsRV30c1ZCgcgoY7
 pLwR2CIDLAvNBVs87C/C/mpZxg7okAYEcXfAQxio5V74KsbRgFZ2N4tf10Qakw==
Date: Thu, 7 Aug 2025 12:28:51 +0200
From: Philip Oberfichtner <pro@denx.de>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: u-boot@lists.denx.de
Subject: Re: [RFC PATCH v1 3/3] Image size checks: Move all configs in one
 place
Message-ID: <aJR_45pg-wsQD3wl@antares>
References: <20250731114044.264745-1-pro@denx.de>
 <20250731114044.264745-4-pro@denx.de>
 <290dd3f1-1850-4bc5-aa97-e19740f46934@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <290dd3f1-1850-4bc5-aa97-e19740f46934@canonical.com>
X-Last-TLS-Session-Version: TLSv1.3
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

Hi Heinrich,

Thank you for the review. I addressed all the mentioned points in V2.

Best regards,
Philip
