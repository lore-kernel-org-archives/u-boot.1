Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 706A3CA5FFC
	for <u-boot@archiver.kernel.org>; Mon,  5 Oct 2026 08:01:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2EC6580CD3;
	Mon,  5 Oct 2026 08:01:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Zu0im8gMKf8k; Mon,  5 Oct 2026 08:01:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 701DC80CF2
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791187316;
	b=KUKSjfApG76h4BUgfQpqGvhk8RQAGD8hwLu4b6KuIa/tVNAq1UNqzcxMQM8iAKF6iP6s
	 6nVi2paF7WlH9/82oB3c4r5CQsl9JJzZuwx9GAiqCNcQU5AfSvXtSkdnJBXGd2SKBYN93
	 vgmmns/tUeQpt2yL2HF6Ca8CnSsANBpy1jmYbbltK7TJTXeZzY+5abZ31UUE8mJrjxThf
	 P4qaETOcTY9DLXBSjONW9ppptMdKSNW1voT1NLx5wC0GdCVaU0k/GynVIOqc9A18SZ0Cl
	 XEeJ92NrG9/DW/PfrKoyRrGZsSxyKkGKzxLl5en9R2DsME197c4KgqTu6eFZ3OG3ndw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791187316;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-MBO-RS-META:X-MBO-RS-ID:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=HYeWDuwBrSar+fDX3esTm1BankZr9jzMBU9C8FT617s=;
	b=cnSMdu+JFrr2sDy8EMHBIeFSF9DzWG1gbCQd2d56zIcmHGThKRiN71+YgRm43mMwfZYI
	 ifQGEjhdNTI52oggt8/lGydi9NUU9jcjyhgJDXcwP7++111o6tDWkeBH1A0P3uP7LuxMS
	 H4jgrQoz4vF6Puwvjaz+oTzsHCGL6Uomt7r2LP/L9zkgIxt3xOmaA88bG5tBJdurYzGS4
	 W3wwnwhi+jCJt4gPAS5vJfrbW7SxG9sW70nrifXJNYWlUwYUh3bPW3qBXHWmKOwamnK2k
	 /bvMClczduBGjX9dBdr0TLwPTrgdTPbyipZLDJI5zCmfSVfo/OVFphI0UJNCUsQtX5g==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791187316;
	bh=HYeWDuwBrSar+fDX3esTm1BankZr9jzMBU9C8FT617s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=NHguCoebgMYQu8i3sG1Mfw00uP+Wxm9vzvtxQ/vy1HsvBuo/NrdNMUAHG9CErLPAB
	 nkpN8jx5eC0nZnY+Yla4dG0cbtQ0Cg4NIMQuOUIYiiK7yj9vtjTOnd1yNEPK/z/ZNM
	 uX2BB/dm6xNW+jLg2KLJUPFLieHyUwv5FbKV8U9gJoMlsxa82dl8Fm/t47oNqrw3hx
	 n4jHRYXjGZ2HpjlXYGcvYBFhmLMjFI4vjI8rtOM9HVjsLAd2ihZX/waKLSRQkSIYFh
	 GPYbavs+nduqYKUoBl2Qk1q1FymFNZBvTyJTLiHLAL9LQqH/FZc5XSPn5JKwYL1aWN
	 Sxc5RUCNMmIWw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 701DC80CF2;
	Mon,  5 Oct 2026 08:01:56 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 09AE975
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 07:58:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E38B6400AE
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 07:58:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yotRGSfPcy69 for <u-boot@lists.u-boot-project.org>;
 Mon,  5 Oct 2026 07:58:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org DD1D1400AA
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=80.241.56.161
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791187107;
 b=dR8QvRcjl7zK3D2nmycQYksI+euANKp6LqKM8bq77CrSmQkgcMnhKKzcatf6bLM64aYT
 sDfZrQ/3a0LaS9/TUWZwKKVq+W4ZenxRQpN35vSYkvwVEFkhi7qGfKZWLC3h91CzXVM6j
 kaZ5iSsuGi+1sbF/9p1gzUZDyOCNvI50txT+uhtHruq4UTO0iHopK4Eq795xt+Lll/O8T
 ir2yQdn7qOeTJ5C8rJVqUowFACgC8RteRhovPgzAPiUb6tJey0chBNa3Eoej9YXh7sTm2
 15YCIsHPA68sqt2iBF7UUmYfI4+AI3vB93GWuCRSfvso3Hq4CFGn7WTfJZbXfI78xmQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791187107;
 h=Received-SPF:Received:DKIM-Signature:From:To:Cc:Subject:Date:
 Message-ID:In-Reply-To:References:MIME-Version:Content-Type:
 Content-Transfer-Encoding:X-MBO-RS-META:X-MBO-RS-ID;
 bh=HYeWDuwBrSar+fDX3esTm1BankZr9jzMBU9C8FT617s=;
 b=ANPCq/bdxijp4bTbyiaiOrpezpoidcO+C6vQD81CDO6vvWXdc3yD+T1MsQx3FTyqKTSu
 hcg4GRKEnIiMzBNw1WdkZWyb8awA5s1a8eq6F9qfzByMsa+6qyf9Pm3qWqez9kCPTb/4Z
 xI8LdPEXRjkbQJcWDhpaGIXApAxqWLhoitF2VmviyltdhYAZdSeP5XmOV0JNLjBE08NTu
 rEizWp8k/0dy6XYDMAw37/8mnfaYbJ6Ue84bRlTbJE7ixe+ztxGxCvqT4uSBHKCyVY5ry
 3mm/TRbPUeXZ99dGzWk0bcjZy6qQFa0Znf2AbEicWKxk7A+6n8gyavN4V1kDuRQpZng==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=mailbox.org; 
 dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=dHi6LccU; 
 arc=none smtp.remote-ip=80.241.56.161
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=80.241.56.161;
 helo=mout-p-103.mailbox.org; envelope-from=stefan.roese@mailbox.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=dHi6LccU
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 by smtp2.osuosl.org (Postfix) with ESMTPS id DD1D1400AA
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 07:58:26 +0000 (UTC)
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4hysFq1jM4zKn70;
 Mon, 05 Oct 2026 09:58:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1791187103;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HYeWDuwBrSar+fDX3esTm1BankZr9jzMBU9C8FT617s=;
 b=dHi6LccUZ790lZ73TMmnqW1l/PATdf0cP95kWGK+l0fyKydN06iHczEx//GZsa+I8HyCBS
 dju16ymQdckxH4RilYNs8ghT35eo7VS+laZYb+/5gsCoJWQO5N7x/4D6X+NxSfkVosjEOm
 9leKo2zdK6Bq7ESBciDoHuEhkQv5NBd0K5Bl86aBZMpu5iU9fTFnKZmaGRrzTyLZex22ff
 B/oCu8JjCb7oT4aLI4fCoGg/KPbYZPn2xEbRYxUWcgX6NG4az9oAaYR4PLwmIYglbzxMIH
 5x6pHXS4He84MAmMllabgEArnj49V4P11T3BAlXHbaykCQmUvVw7L2zMi51IoQ==
From: Stefan Roese <stefan.roese@mailbox.org>
To: Tony Dinh <mibodhi@gmail.com>
Cc: u-boot@lists.u-boot-project.org, Jason Cooper <u-boot@lakedaemon.net>,
 Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH v2] MAINTAINERS: Add missing file entries for some boards
Date: Mon,  5 Oct 2026 09:58:11 +0200
Message-ID: <20261005075813.601288-7-stefan.roese@mailbox.org>
In-Reply-To: <20261002-maintainers_file-v2-1-74a0f9963b19@gmail.com>
References: <20261002-maintainers_file-v2-1-74a0f9963b19@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: xkn56ikkn6ur51z6yi87qxupsk1f7mmo
X-MBO-RS-ID: f98675e5c8e4659fb30
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

On 03.10.26 06:21, Tony Dinh wrote:
> Add missing *-u-boot.dtsi to MAINTAINERS file list.
>
> Signed-off-by: Tony Dinh <mibodhi@gmail.com>

Reviewed-by: Stefan Roese <stefan.roese@mailbox.org>

Thanks,
Stefan
