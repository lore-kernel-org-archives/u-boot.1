Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD91DC5DF81
	for <u-boot@archiver.kernel.org>; Fri, 21 Aug 2026 02:25:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C4A9680FA9;
	Fri, 21 Aug 2026 02:25:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3kCImWSiB6wK; Fri, 21 Aug 2026 02:25:12 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787279112;
	bh=8gYNzudSRYIrX1WCGj0/wVANi7ReiwlCUkmPVBYXoUA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=SKI3b7Ku+diJEZcoblykMtDwOR/ZPOihA7oSzGFJV3KtWJqxZz6aWEUZHB0f6U5EG
	 bPbdy8KPPY16O1YgYoMd8oXI6gPMNM79GFLdUOhYpp9n7SsBCHWCmyYgJ3lSI8HSFh
	 erLXwAeFK/KKqog8FuyIOtyk4tOXxV17pQDrbx8tZtGgcxcZdzL9cRCHk7wzLzWkLS
	 pL1RYa0IqT18iP2sXRzUA7Gv2Kg2/T/QyokHSzTsFJZGnUOuRDzO693nWoL2cKQXlM
	 GScWE/Ymo6ttV1xWXE2l8OUlqDis2X6OQHtjTWXCzPzBoPZGaqK+XPIgxl4HL5Gf40
	 AEP0h1bWTh/bA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0485C80F9E;
	Fri, 21 Aug 2026 02:25:12 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id E7BB31B8
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 02:25:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id CE81F80F9E
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 02:25:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Q-OW19iCFBQ1 for <u-boot@lists.u-boot-project.org>;
 Fri, 21 Aug 2026 02:25:10 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=80.241.56.161;
 helo=mout-p-103.mailbox.org; envelope-from=marek.vasut@mailbox.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=mailbox.org
 header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812
 header.b=W6NdLD/i; 
 dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org
 header.a=rsa-sha256 header.s=mail20150812 header.b=KDZeX4vW
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1C30980F86
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 02:25:09 +0000 (UTC)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4hR4026pxlzKnDj;
 Fri, 21 Aug 2026 04:25:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1787279106;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8gYNzudSRYIrX1WCGj0/wVANi7ReiwlCUkmPVBYXoUA=;
 b=W6NdLD/ixinQUx0sUIbmgOLV3VKEmjNdOb+9A7HxkEZH+ZQ04PZund9vTuFf7DEe1nYeHf
 eCuR6u1nNeNWlEdHnDLhqNTohzMwaPcxSjLI/M6b5c6Slnhwvhe68bg18JCIOJcfDrepsv
 gcinRwGXRvN72JYOSkVOS6K/7YSpLqLbgV3+eMiWVRuOqeYKZw4AfHhIJjgcS02QBd1OHU
 BBt1CWiomfJIDuO6K7yjOtJvIh9iHjLlYEA+KEe3qOzRZXXzxyszlSSk5bdgtE3yMQrZ+j
 ezF+xVQ7i/I3eFFLK61bBVf34GTI9eojj77P1jQ8mDR0+6ceTeH6X1WbmkQVrQ==
Message-ID: <2cb90777-c31d-43f7-aa6a-b11b7dea9f4f@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1787279105;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8gYNzudSRYIrX1WCGj0/wVANi7ReiwlCUkmPVBYXoUA=;
 b=KDZeX4vWU+5KYVwWqDNtSiLbzZ95ZGaAkYmr8JYmObRS3z9mhVPsC+2Ehp+DF/YfJFa/R2
 1LJXSOJcNJB8SybEVJXT/0z0+KDRronnsNT0D17q5wM7w8lKxIoGsuyHQp3QHJybpkxMZj
 lNMEqfEKke1n3DPwSOhEIySA17LxBFZEV/9lUH+pDLnXZSgLpdVaOR5wZocxz8sgUy5w6/
 b4dJL+Jz3tip1MpKk2uhVx147GqHiAWTB1/o+C0fFuY2Nab/Un2rYqy6RjB9fbNN1FWM53
 KHpGBhGUGI+ttfLqvCuL75YW0AbxcWv0dC8Viprwf/RVATYWQIV6stH9pzx12w==
Date: Fri, 21 Aug 2026 02:29:12 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v2 0/4] usb: ehci-vf: take the register bases from the
 device tree
To: Mehmet Fide <mehmet.fide@gmail.com>,
 Marek Vasut <marek.vasut+usb@mailbox.org>, Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.u-boot-project.org,
 Mehmet Fide <mehmet.fide@screeningeagle.com>
References: <20260820071511.1036506-1-mehmet.fide@gmail.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20260820071511.1036506-1-mehmet.fide@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: m1z1don1szfwxh8cscwdjscrcqc3sexe
X-MBO-RS-ID: 1c652a5b08bafd8d64d
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

On 8/20/26 9:15 AM, Mehmet Fide wrote:
> From: Mehmet Fide <mehmet.fide@screeningeagle.com>
> 
> Review of v1 asked for three things and they are all here.
Can you please respond to the feedback before sending new versions of 
patches daily, and please consider whether or not the feedback applies 
to other parts of the patches too (e.g. whether you have to handle 
ENOSYS or other return values all over the place). Thank you
