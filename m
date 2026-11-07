Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11D84606A33D
	for <u-boot@archiver.kernel.org>; Sat,  7 Nov 2026 15:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=LS01ePJp;
	dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=O2dDNrnQ
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D4D38810F7;
	Sat,  7 Nov 2026 15:48:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id k9XywiLC9Efg; Sat,  7 Nov 2026 15:48:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 090AA81190
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794066496;
	b=RL+AZtNTaSULi9ZAxdo8zuJ0mns5sTpQLeYJSBY7QG5SvWVBld6jwuuWIKfGv/38q0kd
	 aKBD2cngPJfGqevHl34cmXbG7weQkxkw5w5A4GTHfGcAlKF9uIfoBAZRtofwKjM5LbosN
	 3bGd889nC3voRzZAsGkCwrkFXrXtG84SLLw9k1dyEh1fRvxgLlKzsftmnZI6gA7n/wvUO
	 YYAHp6Oh6796auo1hrZ1evF96ZTHjBtYSJvMFnrcbRvPM/+2BHnEN6lmvIrr5om5sOnrS
	 XBxtzVUiZ44aOBGIuR8LT1KlrrSQ1LPh9mfAYrh5Fh9GUS19Ib8FhCE8iVJGNnMn3KQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794066496;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=761BqgoOTBa0Yd4YbdrKOsMkyetiGtxBTJymuNZuhys=;
	b=IIHRubTF/vgC83ATlyE3vpVlrpdaAO2sLcyFIIv+IU7anzt9pxoyzACarOvg4TnW6MAq
	 9sE+fAKfZhCHIJIMdcbJ/S8KeK/060xqxH3QHOH3ViCM36lvXSvHL0WwW2exY276WLTgm
	 RhQixCh8cBPHuDQynSj8WDdpM04kTp7cEbLl66kIGzPfKnj2IiaJKDEGJQl7a9Lxxl2gL
	 USnyD1C8CHwTAYNUrixQNn2Uog7Nt2J7SY8yr2IfT82p7aF3+t+iKZ1lmZwO3Fpn9cAx0
	 oE3U30GOnmvHxZ11Gzjrts9ypJcBDGSl27MoPy+40TcJXTY7fmgclkAZlZVHQmqa/dQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794066496;
	bh=761BqgoOTBa0Yd4YbdrKOsMkyetiGtxBTJymuNZuhys=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=LS01ePJpApGzER3fZ5hhNXgkQBW97yJOrc4APDpXzwnU3UPNVXDHOODNsgfRUvyEY
	 rqsFzlNQ7pOkPP3jOh+RryZqD8f8ybO3iIn3ymxLHJUTWpolH0nrv/hyFYCz1UkV/u
	 RXspnjkGbihaZ+bhomRwIdb1xiIzu59yoiYLv08iG/CYKOP339w7me8Ni4oCOF37BT
	 DrlNQmxL2YmyMLoWZUsBGhzObZlEiWNS9ouBEcwXmaeOKozBqKJ1iOJE2mbKZDqhba
	 ivuizJ9bE46+vWjdOvpk09osv9XuO8bvMwQYRgwqjMLvhTIu5T4TcQVpxR9igKf8MR
	 K5g94goOur8pw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 090AA81190;
	Sat,  7 Nov 2026 15:48:16 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id CFFD037D
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 15:48:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C0911400CD
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 15:48:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kJJ-EmqAjeon for <u-boot@lists.u-boot-project.org>;
 Sat,  7 Nov 2026 15:48:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org DE14440050
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:31::9"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:31::9;
 helo=mail-oo2-x09.google.com; envelope-from=trini@konsulko.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=O2dDNrnQ
Received: from mail-oo2-x09.google.com (mail-oo2-x09.google.com
 [IPv6:2607:f8b0:4864:31::9])
 by smtp2.osuosl.org (Postfix) with ESMTPS id DE14440050
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 15:48:12 +0000 (UTC)
Received: by mail-oo2-x09.google.com with SMTP id
 46e09a7af769-85f1800532dso809092a34.1
 for <u-boot@lists.u-boot-project.org>; Sat, 07 Nov 2026 07:48:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1794066492; x=1794671292;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=761BqgoOTBa0Yd4YbdrKOsMkyetiGtxBTJymuNZuhys=;
 b=O2dDNrnQlBtcLZxJmMiUPEuh5x13BoaxQtvWCyOdJT06zRtnVNNZoCtdqoMcFi+9cH
 BvpkY+YkyDrOwKkf9sKwK4k/yQNKhPmow6z/geo8eMldA8TPW5G4bEdK3FgOytlC1de5
 9HNICrSKM/M7HqVKlDMPQr1aUJro50TpuOv6M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794066492; x=1794671292;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=761BqgoOTBa0Yd4YbdrKOsMkyetiGtxBTJymuNZuhys=;
 b=P2caKHs7EC2cXKSbOSOMdn/15HAthoLPQglsUx0OIVL8ytD8pDhjsiD64oksZ9lEUy
 ew2NsIwjRhgMmQToTK60s77J5sc6oBBd3LZ6MUPn1qtJPw2AnxF858EgdjR+KWQZkFl9
 X9D8DaKtNL/4ofIoVGoj7WPp2Vn3X/jekc80EgPQ68aIS6AFyaLxr+JtuwSuOI7omHj5
 wvPCMj/P2oXyHFXEXWnzUUYkCxhtdbPwMJR8nGhW7NCZlwkpWWG6yvNAG2ldGY643KIL
 zl26PXuLG+bjVWyHFEyj0FJlLdga0V+Jx1bIh/8kkRqsFNKX94HVNyhDaQA+AfyoDrUM
 OzNw==
X-Gm-Message-State: APuU4Z/vgyjewAdMuXrqGEcIx8zymFWzD+P7OEB0+V04ULzkursKfXKj
 kCjpPCpULyTy0JFKiLifCvb12NWKfwDxQ6wfFduDwI/XdS+pr0+jhHMurZKW1dbab4fbPXDvTcz
 6iSSf8KzycNWyDLc=
X-Gm-Gg: AYBFou0mLhKjBvT5DQV5eN/R/FP3bcYPTIY3rqM0lo2lW2fNITsItk/DFt4M+IDe5Qa
 s4KBNVC3JFHJJhhEK65Ys52O8TVzojmV4CYK7JKCiRTrjOj4XSK9G/vXHmPn9IIAhZvhj3GSzmt
 hBtMjdDcbsQBN1Ew/vrbOagOmnDwQtI5HJx6uJllcWldk6ItEBdfJSLLd39mTQFV8sU9VgtOb+u
 kSuwD/2ITRUHIHkx3EO1iEV3FaDYpSG94oBEQja62KWXkCP79v/Zxswptjk/COYDZ3H0zzEu/Ay
 e1ppyL7EkZPdZm4tWhZRXiOx0CSrU9lxLZsl9WUKpoyMsedqliZeIah4AiVb2Fo3YDHYXy4dAVr
 Gk+4beBcoJwl3Ovhs0jXVyvmvc6z8/3Ke8cuKup4K2bASuDHuYuXFmwdOfSgJK+EQ2XVcEUQNJk
 GdnLxs9ZEyDhALP1FkbKklRgxYnxafGrywDyvlCJt56AfcetyBFtmIePIM/A8GsJ2zROSHEfXFG
 t4a3MZ448AEC0ntqX2jPO7S5SgddOkrYGanbOHmZeYV7iMHlXb/ettUvg3xjIuBqoQ5F4r9U1HT
 xSj4QGJeAwnxay7ERKuFrrCp5yclwWKeqhJBg8MbF+Eh2m2nBOwtetokEoxmtECCc93eW9IqzYl
 HPbApDPOcJ+B8RgeY8d4MFIWFMnwrqvFc3nQLmm8lPOXKNWvUeedFSJbggQGd1vy9IB01C91fSo
 cOY/FEPyhvbJppkNsNQx6WD6M7N68e9A==
X-Received: by 2002:a05:6808:3383:b0:4e6:9390:e153 with SMTP id
 5614622812f47-567e151a9bfmr4256533b6e.24.1794066491637; 
 Sat, 07 Nov 2026 07:48:11 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-567e7f010e4sm4064106b6e.14.2026.11.07.07.48.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Nov 2026 07:48:11 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: Stefan Roese <stefan.roese@mailbox.org>
Cc: u-boot@lists.u-boot-project.org
In-Reply-To: <20261107100520.2092641-1-stefan.roese@mailbox.org>
References: <20261107100520.2092641-1-stefan.roese@mailbox.org>
Subject: Re: Please pull u-boot-marvell/main
Message-Id: <179406649084.4067238.4449211748382480086.b4-ty@konsulko.com>
Date: Sat, 07 Nov 2026 09:48:10 -0600
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sat, 7 Nov 2026 11:05:19 +0100, Stefan Roese wrote:

> please pull the following marvell changes for the main branch:
> 
> - ata: ahci_generic: pass the AHCI device to board_ahci_enable() (Igor)
> - arm: mvebu: set up the AHCI controller that is being probed (Igor)
> 
> CI (GitLab world build) is passing:
> https://git.u-boot-project.org/u-boot/custodians/u-boot-marvell/-/pipelines/1871
> 
> [...]

Merged into u-boot/main, thanks!

-- 
Tom


