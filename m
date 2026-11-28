Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CB64606A33C
	for <u-boot@archiver.kernel.org>; Sat, 28 Nov 2026 12:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=iZX1Ihi8;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=F0/Zf5x7
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 36BE260611;
	Sat, 28 Nov 2026 12:41:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gGcigZ0hrRAs; Sat, 28 Nov 2026 12:41:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 1420B6061F
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795869661;
	b=IBh2eSHjUZvEWfeErSLENN8JYNHasXMSPzDpl/xVtrqbbL4d2Q5qdnc1gMAoJgoDONyt
	 LYPyZr2S+rDn/ppK6LLgR1RtNhNjom7uQ9EocemjZHAU3DjxTCjuOQ2MvmnozA5VTmXDm
	 D1L5Df22nJtb22JgHjbgQqQCu3IgKHiWch1B6vt8rIwARavtkKj8rF49OIZsiZSZpj5rC
	 9MpqmdFvbzhqqEiiJiNLU/fs+82XeiglcJJAUSXg38xZzmrhysWeft6fVcivapU49AGuF
	 nc3xXGdLeAgAeYaoZFRX7BHJ/MvuFE6rvxw+by6EXZt5WSnCwBJiKZBMd66Wx6qvzEA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795869661;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:X-Envelope-To:
	 DKIM-Signature:X-Envelope-To:Received:X-Mizu-Trace-ID:X-Migadu-Flow:
	 Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=/u5MpR8nq1AK+0I4y8t2aEXq4YewQ68x2FHZfLaazo0=;
	b=qNOYD3YM40iqv7sgaC+VSjpyvzqsI22zJU9iZ92bRAm+U6n8yFBcGAaKrKjBMv2jZ3/Z
	 EHGuVGZT2ddYnn6NGbKHXOxgpQDK3pZ32c60YmUtzy4YjhLcO+wULK1XeJ2eqEuYXOpB4
	 2N1CejAdIN37uNtYU91wFRxNGIocPyrvzt162aJDpERGylgas05r8FaZm2ccNjXlZpiEK
	 hF0UFXRLJRKPDqL5WAN+hHcfgVjzyDDxiYBFc2O4LfzFzYY3cEaGRTujQU5aDcYUivOCo
	 v62woMoHeVKuRqTapKAbiWjKUCC6Ix4lGBrsQwj8UUpWdlHdH9leJCQtJ9GW26GsxVg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795869661;
	bh=/u5MpR8nq1AK+0I4y8t2aEXq4YewQ68x2FHZfLaazo0=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=iZX1Ihi88izyIBofqt8CUxmzlpRlbCyDEJIEnEV6PMiXvsQLXHE0HOtVMXZy1vY7e
	 d2O+n3OIGDnbBoSPjD+hhxGRNVw5bDPhQi1IQoFOv5q4osS1CK59t06ORQjAA86l5Q
	 eqr2TBdN+uf2lBpftLoaki1m3/X+RElUHtlTSUrbjzsoWt1DVJ8bAJ3Rz0Mikk00J6
	 2iUQmtmu57jqGIHlkoGDVYTmdMINwM3iXi0F57bRooZQfthCPQTLZ9mBolAHuW3HJ3
	 RLEB/TlOCOOV9wSqDJwIG38/76LbRktckaXIlDOG05jpvhZ8I5jhz4Lm+3JBnHpJJH
	 1kthUKjXAp7qg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1420B6061F;
	Sat, 28 Nov 2026 12:41:01 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 78D252FE
 for <u-boot@lists.u-boot-project.org>; Sat, 28 Nov 2026 12:40:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 6A8A44050A
 for <u-boot@lists.u-boot-project.org>; Sat, 28 Nov 2026 12:40:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JNZ2ZGckTc4z for <u-boot@lists.u-boot-project.org>;
 Sat, 28 Nov 2026 12:40:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 637CA4050E
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2001:41d0:1004:224b::fb"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:41d0:1004:224b::fb; helo=mta0.migadu.com;
 envelope-from=bradley.morgan@linux.dev; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256
 header.s=key1 header.b=F0/Zf5x7
Received: from mta0.migadu.com (out-251.mta0.migadu.com
 [IPv6:2001:41d0:1004:224b::fb])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 637CA4050E
 for <u-boot@lists.u-boot-project.org>; Sat, 28 Nov 2026 12:40:56 +0000 (UTC)
X-Envelope-To: u-boot@lists.u-boot-project.org
DKIM-Signature: a=rsa-sha256; bh=8VW/URKr3drNY7YD/AWKAvZoghfm/DAB8wBUd3zHm6U=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795869654; v=1; x=1796474454;
 b=F0/Zf5x7xQaTJQN6hTl5FKG5zHGBfYNt25YKiKmtT9VFbsYmhT/BZ+2MycY70/nqmalGewGN
 xYqEiXxXA1SbKiYw8lvcg2PH0InUefhDmJ1O6VjOY3YUdMy6nCpPc3a/WbZD8Nr2KuQkfyj/l9l
 vJ1ut7bgVpHJXokRab5K8vC0=
X-Envelope-To: u-boot@lists.u-boot-project.org
Received: by smtp.migadu.com with ESMTPS id 3bb9db4c6881e23a;
 Sat, 28 Nov 2026 12:40:54 +0000
X-Mizu-Trace-ID: 3bb9db4c6881e23a
X-Migadu-Flow: FLOW_OUT
Date: Sat, 28 Nov 2026 12:40:52 +0000
From: Bradley Morgan <bradley.morgan@linux.dev>
To: Jaeyeong Lee <lee@jaeyeong.cc>, u-boot@lists.u-boot-project.org
CC: Tom Rini <trini@konsulko.com>, Christophe Leroy <chleroy@kernel.org>
Subject: Re: [PATCH] powerpc: mpc8xx: remove unused I2C DPRAM definitions
In-Reply-To: <179585333468.377168.5944554103549100837@jaeyeong.cc>
References: <179585333468.377168.5944554103549100837@jaeyeong.cc>
Message-ID: <32A2574C-073E-46B1-A5CD-A4BB0A7DC332@linux.dev>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8bit
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
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 28 November 2026 08:08:59 GMT, Jaeyeong Lee <lee@jaeyeong.cc> wrote:
>CPM_I2C_BASE lost its last user when the MPC8xx I2C driver was removed.
>
>BD_IIC_START has had no users since the MBX boards were removed.
>
>Remove both stale DPRAM definitions.

hi, this LGTM, cheers, but I feel this should be a 2 patch series.

>
>Suggested-by: Christophe Leroy <chleroy@kernel.org>
>Signed-off-by: Jaeyeong Lee <lee@jaeyeong.cc>
>---
> arch/powerpc/include/asm/cpm_8xx.h | 3 ---
> 1 file changed, 3 deletions(-)
>
>diff --git a/arch/powerpc/include/asm/cpm_8xx.h b/arch/powerpc/include/asm/cpm_8xx.h
>index 98476cdf..6a7fded0 100644
>--- a/arch/powerpc/include/asm/cpm_8xx.h
>+++ b/arch/powerpc/include/asm/cpm_8xx.h
>@@ -52,7 +52,6 @@
>  * DPRAM defines and allocation functions
>  */
> #define CPM_SERIAL_BASE		0x0800
>-#define CPM_I2C_BASE		0x0820
> #define CPM_SPI_BASE		0x0840
> #define CPM_FEC_BASE		0x0860
> #define CPM_SERIAL2_BASE	0x08E0
>@@ -60,8 +59,6 @@
> #define CPM_POST_BASE		0x0980
> #define CPM_WLKBD_BASE		0x0a00
> 
>-#define BD_IIC_START	((uint) 0x0400) /* <- please use CPM_I2C_BASE !! */

2 in 1, makes sense, considering they ARE mostly useless.. yeah, ack.

>-
> /* Export the base address of the communication processor registers
>  * and dual port ram.
>  */
>

--- Thanks!
