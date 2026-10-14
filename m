Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CF3ECC6B1D
	for <u-boot@archiver.kernel.org>; Wed, 14 Oct 2026 10:44:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 210C960751;
	Wed, 14 Oct 2026 10:44:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hINFXIB-Y6Og; Wed, 14 Oct 2026 10:44:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 1F9DE6076B
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791974646;
	b=MB0H23CywWPzlr10cgxdAPpCZsaKuejQ8Kwh+5FV5vHATrOOwISNvL8YBTCApxxpib6d
	 rKIY0gtX9y8m+5BCkOe4pQzrUb+3vrKFH8LIhymsDtYoCyVf4AjvXimuPFwXbJll1f7qV
	 DGAA1t+nykmyQIYHTG7CqSkYI4seTYfXxou5A+6wDQUUq+Z4LdoNiRDL0Jtiq8R0/jM8T
	 24cdswlNzns7Q+pMwQivZvviPmwZVJfqwSHYZ02Bn+2x3Q8k03VtMI7u2RGWDkDuxMi0f
	 pWE7bQhZTdroJGZZv/sB6szjbZnJV42w1CBcWLUQXGkWqLMtWgTCo32E+HtIb25muAQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791974646;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=PD7hPUkmfP95rEIWLy1r/UnvdZuH4BQU9UTHobuZmDY=;
	b=RgqbO6Iigx3uzhUTFCY7Cmb67831tT0K3I5FUb5284TcAQVz+oci8FjSv/Tq7q5eT9Tt
	 EyxYo9WrLlH9QRhi7vc7/M2lGmTmdFflzgdSpoIwKNVZzrNktG3NWRKzrwIH95Qpmg/lj
	 zFqwO1P6dC60UdLmeCwkKC+v5PC9jiIGHvWP0VX1/hXqM0Bchb5sbLW7wRKLGQBd9aF34
	 RBhAWHGh9cMMMoD3pVu+dYwpAvXconpuJSDJQ+q/aG4Q5hVRHcffNuW2jo+jJ3cCPWOhf
	 5a7Q33glO7o6QE+UJWLJrk9NSeirhS0m+vX/Jn2cmre7gGjzoWDMxFS7ZFmyO3hPL7Q==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791974646;
	bh=PD7hPUkmfP95rEIWLy1r/UnvdZuH4BQU9UTHobuZmDY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ixAOhVIoqiW2NSUZj/GSs+WFvwFfhbu9Jrzo9ReEr6vkjBeuJsZFxcf9N0ifCMumL
	 kOpNejDG+zYS8DGqijyaFnAx7RGz4sNxScIMRvKGtew3Rb25ZPAhNENadlHdykpvMM
	 5LVwY7h+KojYvi2uUYC7ylaJVgEQ2JGKWjU5CWlnKeTVDmQREYDrBvz83vII3UooF6
	 9wFV8rivEBcmhkoYd4VTbi9vlGNQLvVTIa2GonvKCerRWtqCmwAWXGGX+uxzjdMbYV
	 ZJmQZuGNbVkSs0u7EDVXUkFaSY/H8gRx+aT4XnzqnQbO8tRUabaCQIKAPYv9t8uUXx
	 Z631lElicn4gg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1F9DE6076B;
	Wed, 14 Oct 2026 10:44:06 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 5001F1E9
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 10:44:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 416AA80C88
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 10:44:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2HGmcXeBPz5v for <u-boot@lists.u-boot-project.org>;
 Wed, 14 Oct 2026 10:44:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 0BBF5808C9
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2001:4b7e:0:8::81"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791974644;
 b=aGjC0l6Vp/5mafly2J5ldV4LbzPUqapTHO1+/Uj8buE4LY9t0x71BLrVFRm7gkAtMUrT
 chnqMGsY6ubgT/r+8hBE8/SsoXvu/Va3pPyu/EFXiMi16LxRtLiKx8co4e0EBJQ7QOpjK
 +Z2McpY8mCVFSaG9peRpOoya4bMQ02v0b7ZtTKkKQoGYaS8P0cP7bMCcKZsiMbce2kQpz
 s3UkGmh5p+50Jca8kpQlOciLOZNmNCgDvxvm8q4oXXKrNviTr0vPJM+Hz95wEM/gtWNQj
 pTVlsybyxpMr1NrXLm2hG94mCYROnRhq7bWIXHWuEe+5vPNOJ+cFZH4iOVwXKa/wzqw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791974644;
 h=Received-SPF:Received:DKIM-Signature:Date:From:To:Cc:Subject:
 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
 In-Reply-To;
 bh=PD7hPUkmfP95rEIWLy1r/UnvdZuH4BQU9UTHobuZmDY=;
 b=MNcLkV+YBMMjr+FKkvg5dzP6nsNTBZ0pqCtDxFi7JxoHzTL0zIQhm6bLB2gYqkvuVdK6
 afBDPp/4TV4zI9XszvYRszs+lxNDHNvn/CwC4YHTEdFq9FbS2Iy3O1vqjkD1udtbiadyR
 TISXLfKjCE3Me+q1GmVr+2CuRg98qokvQhVJZJNyhxyznbXOSFIMOg3dyIhtj5aM52Djq
 y/Bf73Mr0Q/0EcpQt1As9bzzGSItJNEkG4qlNto5UEHe5VBT0CvMfGLuc7ClsZgCBgyVH
 G3sbgsf91vjss37yUFU3T8zsSGVJWeBL+VQg77y7Eo2Pif6cm5UY/i/2P97uU2YA+Rw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=dolcini.it;
 dkim=pass header.d=dolcini.it header.i=@dolcini.it header.a=rsa-sha256
 header.s=default header.b=xDWSl3k4; 
 arc=none smtp.remote-ip="2001:4b7e:0:8::81"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2001:4b7e:0:8::81;
 helo=mail11.truemail.it; envelope-from=francesco@dolcini.it;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=dolcini.it header.i=@dolcini.it header.a=rsa-sha256
 header.s=default header.b=xDWSl3k4
Received: from mail11.truemail.it (mail11.truemail.it [IPv6:2001:4b7e:0:8::81])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0BBF5808C9
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 10:44:02 +0000 (UTC)
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
 by mail11.truemail.it (Postfix) with ESMTPA id EC77C1FAA5;
 Wed, 14 Oct 2026 12:43:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
 s=default; t=1791974638;
 bh=PD7hPUkmfP95rEIWLy1r/UnvdZuH4BQU9UTHobuZmDY=; h=From:To:Subject;
 b=xDWSl3k4v1udwgITaWPGT/WYwktXf0uG0K24mr9zskMTjxrgGmFQSnGerzYkfNYUv
 6yyWlTHqFgO+aBpWCLjcHQaUCHNsxtXfZrMIUMSVERUr6BGvYIyutPOfg8ID4/vwEu
 +zAPn+kXtFVH0ObWUOUyK7qx+y6DMJLndEMfjuesijorAbRRh1wtWOqaQ1I0X2RlTG
 nmEKmus7brUKobCL7vLXjn86WpTLLsneGQyAmgLpxQm7ckScxpcRIionVD7zFiYmEv
 +ugPLkrBhSy2oAEBxnbqvhyDUNVPAwIxdolokKz4h3jzhniBlW++8AFvFVolA/o/Dm
 /vxzWJEF6P98A==
Date: Wed, 14 Oct 2026 12:43:18 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: ye.li@oss.nxp.com
Cc: festevam@gmail.com, u-boot@lists.u-boot-project.org,
 francesco.dolcini@toradex.com, emanuele.ghidoli@toradex.com,
 peng.fan@nxp.com, uboot-imx@nxp.com, alice.guo@nxp.com, ye.li@nxp.com
Subject: Re: [PATCH v2 2/2] toradex: {aquila, smarc, verdin}-imx95: Enable
 caches in SPL
Message-ID: <20261014104318.GA63298@francesco-nb>
References: <20261014100915.3470159-1-ye.li@oss.nxp.com>
 <20261014100915.3470159-2-ye.li@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261014100915.3470159-2-ye.li@oss.nxp.com>
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

On Wed, Oct 14, 2026 at 06:09:15PM +0800, ye.li@oss.nxp.com wrote:
> From: Ye Li <ye.li@nxp.com>
> 
> To enable icache and dcache in SPL, add the definition of secure DDR
> space which could be accessed by SPL and move arch_cpu_init before
> spl_early_init.
> 
> Signed-off-by: Ye Li <ye.li@nxp.com>

Acked-by: Francesco Dolcini <francesco.dolcini@toradex.com>

