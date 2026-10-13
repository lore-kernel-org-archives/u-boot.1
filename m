Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAB67CC6B1A
	for <u-boot@archiver.kernel.org>; Tue, 13 Oct 2026 20:19:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8621440698;
	Tue, 13 Oct 2026 20:19:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HRsOEzL2m99J; Tue, 13 Oct 2026 20:19:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 6EE9940627
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791922788;
	b=pdH3NANsCI42QbVGIGMkf1k3tRsxYK1cCY34itKtdoneRe1FWX4asfxB2BGxZNNcc9cB
	 m5EoPGSCNkYNqpmUo9fxUEMFIYsR9iJjDKVeXmgvRYHd/mK6QmZRt1WT6CeZG1K5sxsa+
	 JiA1o9JtAGtnqF7aFB8yGL1OFM2MMIkLZrrPCzsbTV1vTsHwFxdhYZrHAVzjPqfWz0TeP
	 NRu/XnCT9uA6T5DLbaoTpfnVGsUefL4UZfA1hr/uDV8oJdJC70Rhf0JgCyWq8XAAvzvOE
	 b8Kh+EJURJRUR2tyrImfzZYBqNWE08PasrLhYmYsCW33q7BIZCtACZslX1dC6NmLibw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791922788;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=eJscjjIqBgsejeH2d2HtpnAqmlrCqj2BHw+/+WAYh+4=;
	b=FwZDU4++PvAFe9bjTGG1WAtsqodWT1BQt19dc0gtmOcBhDIg+hxXHNIK8+GwphsnmBq7
	 TxnvPZvw2DX8YaN+v0j9RowWjHmEVb5zLc3b5+Xh2cSe9bPwciYD/F5/ntJj4wih6oqvE
	 ZjE3oyjoGojGHx4LNMOZVZWbdUgZmoGfkJvhkU3Ek/lCE1qHNiGEJdFrYDDrVyiV3mFCK
	 Gn0ITvXDopBNoScGavg8oyOjeAHjBw1LUxw6Egtmxzk+ldN7dba/JtLAZU55uzPzE2B8o
	 TbYmN4eKM5p2OnlmzozjxFclbrIoXCU06dVsUIH4gHCUdrs6CoJBVqL4UUnZI18wiKg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791922788;
	bh=eJscjjIqBgsejeH2d2HtpnAqmlrCqj2BHw+/+WAYh+4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=MiwArEZsYW4euyB3pCpVSQxy+anZsWJKerQ6zXaCU1ERfybTN7Ic7ioBKQIZ/4eBV
	 1z9xFNd0jGLqEtHOclfx3q7LKrGE9UzyGovlnFPbgqBzhtOq8F+jHDsmIh9QzP47b7
	 E3KSXE86czhoYfikF1b1Pa8a2LPt/KIEPc7yL5kXpiR1GrKWdt2y4ZBruk3/CWyZKy
	 78KjszxA1hfUttC+6fs7Ml00JzE1P+bTZVxPHydAPmqiX3J095E09T7mvF2xQtMeal
	 AnxtKJWquTuI35busVb2Ma1r6KKblQr+YhaCkZOVyepq+KbmpLaqDhMVIPNsfJUUFs
	 C/bX5Zurj7YWw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6EE9940627;
	Tue, 13 Oct 2026 20:19:48 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 337E7255
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 20:19:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 253D480CD9
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 20:19:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pkiU0dVGQdBM for <u-boot@lists.u-boot-project.org>;
 Tue, 13 Oct 2026 20:19:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 7DBFE80CA2
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2001:4860:4864:20::35"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791922784;
 b=AYLDh+aJqsMHwCbR7HE4hp0ChxA45zwiVdSRS64nhacphvuVeWz5TCjw6of39Nw7VBqn
 3DifbQZunWJYK3MThaF8zuo4nU6AN7aF9QtBt7j2vWypWB2AtfpDIbyE1K5goLKzVt0Z+
 ZLsqwsy6yeG4384Om4lCkOtwM6xq/qBAZcXDeYIZB7jzEwL5WmN6b3uTPlzD670V0Pod0
 sfF54ZsYYCt/i5pKEFRz0X/SGClCEwhrhT81QVOQB4YAa2HfnqvJ/V0XIGAVGmWVtYrVm
 igKHYPcQkeUG8P+lHga04Rj4ercVwnVMyaT72re/kn+cWsfXqQQCTYX+vwKDiwUmVZQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791922784;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:In-Reply-To:
 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
 Content-Transfer-Encoding:X-Mailer;
 bh=eJscjjIqBgsejeH2d2HtpnAqmlrCqj2BHw+/+WAYh+4=;
 b=JwR6xL+Uk/e8bD1R1HKM7zVCvEnLWu9ZD9AAHu4XVG4rqqOF70BeauZRHWxd4icsaKqZ
 cIrNeJJ6gu8eBw3tXC/Vlj+0ohRn4CVdbI9BzAwbchK/vP3ZkEhSTjzwouKBah6f3QEwr
 AHtV0wi2E71I1TfA/uJkR3JeFZUs5ExXA4ARXRM7eQnoClAjR5Dj6kaf5L279aHJUZjOy
 ELUgS1DolqSXDXBNbKnAfSLxPJt4OiBaPk2JXSQRnZ85zomlP2ehS9/xIiaBw4FHYGE9q
 ThLS/xMNiFk06rAMQTN77RIpMVwdZaOvT1QtgltQhfhbFeTjfyKDCpRK4TWjMpYLlcg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=konsulko.com;
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=pIpKWhDD; 
 arc=none smtp.remote-ip="2001:4860:4864:20::35"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:4860:4864:20::35; helo=mail-oa1-x35.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=pIpKWhDD
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com
 [IPv6:2001:4860:4864:20::35])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 7DBFE80CA2
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 20:19:44 +0000 (UTC)
Received: by mail-oa1-x35.google.com with SMTP id
 586e51a60fabf-490d838b425so1966616fac.3
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 13:19:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1791922783; x=1792527583;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=eJscjjIqBgsejeH2d2HtpnAqmlrCqj2BHw+/+WAYh+4=;
 b=pIpKWhDDSG4Al+9Vd3WEL2wHhc3NOZG/OsSWzY/vmoJt9U2eP4JSGxIas5j5yu11rq
 p/TU8wJ4N6PpBkL5oC1Y+jSlvO9mG/85bwFwf4D6XtkPiMuYuRgWQWaB1pJg5Q6EJ1mW
 VN9hSqWb6OCHW5XBEgVO+QYhGPcyw4ORoawh0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791922783; x=1792527583;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=eJscjjIqBgsejeH2d2HtpnAqmlrCqj2BHw+/+WAYh+4=;
 b=vPikf4tu+8WqgvK231AcTTfHKmPA9+d9pUQC1eafPAbgvMkke/073e17slqOjUPE9T
 L8TiwS+yzKBC0lJXQgASCUY8YxRMAoTarru2XbnFUjmtQ0aim0/SQBlR3WXxqN9G/9i1
 BMkArptQl5ofJ1tGIUObRlITbU9QX9TwKKubieqcoOxhtk+FHdX8faoNtcCuAgTWPgbT
 gJNvv3Cw7lA3C6bTAR2lMoEYOFp1kHXJvEs9GARDyU8MHWFvh/LTQDsbGPtQ4+b0jO+I
 dmp3q7GMyvLgYqRcy3gZwk/+Y2fZmWKhoveklpVF++gQAeBqySo8EO15aaebxxXnENJD
 zdxA==
X-Gm-Message-State: AFq9FYKrB4i8mm2GNiyfXUM8Lj9Yg68G5mvwxldtfsHFBfiYj4cqJh92
 mB0np8cs7Lg4+XwfVoEcBuwgywHz/1EZDIDFKADTTJMo0zJjmlKhP7yKnBTmLWsGsZE=
X-Gm-Gg: AYBFou3a4Y20PCyAySrZwTj4AdoktmpeYwfZpQmaW9RNk1Bo9s3d4BAy2NYQ6K4Afhv
 azcA5L6ESgUrpXLep1W7YufgMSc+fN5EJdykafqpup2TRHLynXp45JKNlyVAfvkJM+wHZs5SpK2
 lTntTAkmJHYFR+9NnKPj97fiJJqpLaaPGW1GJvRJ8O9cjoxfxkQCK1iZXEqpe/u8cywY19+IMvW
 8xFuMgeS3V+HFSN53XkIkN1/NvnMDVX3p2KU+gUkP+4cylkt2v+bT7Lqnk9hYRdWWzEtZX5GO7X
 /x5q6F2Ycz18kZUdU8JA1L/A0qNVyBMEvAGNco8uyFwj26e07Ex5hhnEDM4YI0z+j6RHrIXunQS
 T1eshcQ6okg+BjEL8ERFkWQCz4qnD+Pqx3wVW/xFOZll2P/5kXJrThNCkfajBUSpGrrC+W0YNPZ
 6OfirsvFj/HrT/m/GL4PAEwFAj9SHNsJ/Pfn3X+5rK2baweE7D6muRT9hJGAYmup72cC60eMZFI
 fBTikKoRmyEgq8q69YUx2jdrGfr3qLJTbKe2f8NwsvmCTAvWFfTIKhzYE0EGjeiiLOU1ADFnMV8
 W533lC2X65KdFs37pQ==
X-Received: by 2002:a05:6808:1495:b0:4f5:4eb5:1cd3 with SMTP id
 5614622812f47-50c5abb6c1dmr15916832b6e.61.1791922783142; 
 Tue, 13 Oct 2026 13:19:43 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-50c1c120ae6sm15016505b6e.17.2026.10.13.13.19.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 13:19:42 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.u-boot-project.org, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: Simon Glass <sjg@chromium.org>
In-Reply-To: <20260929173244.369402-1-marek.vasut+renesas@mailbox.org>
References: <20260929173244.369402-1-marek.vasut+renesas@mailbox.org>
Subject: Re: [PATCH] cmd: config: Add additional embedded text option
Message-Id: <179192278169.4115168.10731444024331979767.b4-ty@konsulko.com>
Date: Tue, 13 Oct 2026 14:19:41 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
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

On Tue, 29 Sep 2026 19:31:59 +0200, Marek Vasut wrote:

> Add empty string Kconfig option, which depends on CMD_CONFIG and lets
> user embed a short piece of text into the U-Boot config, which is then
> printed by the "config" command as part of the embedded .config.
> 
> This can be used for example to embed OE /etc/os-release into the U-Boot
> binary, which can then be used to identify the exact OE build from which
> the U-Boot build was built from:
> 
> [...]

Applied to u-boot/main, thanks!

[1/1] cmd: config: Add additional embedded text option
      commit: 400e46a0df848db66ceaf3ece26786f689789163
-- 
Tom


