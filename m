Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3D14606A32C
	for <u-boot@archiver.kernel.org>; Wed,  4 Nov 2026 16:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Mcoe7DB3;
	dkim=pass (2048-bit key, unprotected) header.d=mainlining.org header.i=@mainlining.org header.a=rsa-sha256 header.s=202507r header.b=WFBiZQ+f;
	dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=ed25519-sha256 header.s=202507e header.b=/+osFSoU
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C8EEA80C50;
	Wed,  4 Nov 2026 16:24:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MzhaWMvfPA0T; Wed,  4 Nov 2026 16:24:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 3F60980C0C
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793809480;
	b=B9/aSRb2qxYPU2BQtA6ZibzB3NcMvsgyuEVVUiJwXI5QrIk3k/4LLYdv3CS8wS1EGJNV
	 zTG19qzUWfwavL+xlW82l+MzrNWPIqp+W+UDnCuzSXR6U8Vl1UxTRKZmmvB9t0JGtbhVW
	 gZKnwV09Lwif9mefTSoU37F8vsHFvlxjbQ32dYM97qNgXf/B4xmvx7W7JylefdEoA1IEa
	 OS1xZiEA+0Pag+bTDsdwkrOX08CPhistC1x9JNfpkSCR7rCPnJ8H1RnAxRMJ4FPtgPGs4
	 o4Tx0yBS6cfi0J/gOsivIVDUKMicgPPmmTUl+7qDoy0sSNwW/5qvezh1ZOkcTn7+iXQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793809480;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:DKIM-Signature:Date:From:To:CC:Subject:In-Reply-To:
	 References:Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=iwj8qD50w8Xeyaej9HlfaTT8RIZQVfAdisjRB7sGos4=;
	b=XvcVtPji0zqdzl4ubgalPEXBGT4Z8OAfvf0hBzmsWo2un3jPY7cuRkCXBEu9oVX8Kpgh
	 hJLvneXhJ80G33DvHF4iDGRrjScFIPQz4fcQubZfPLCIBl4NXEIu54cs4iu9ncs7nK1OV
	 VuNENTFyMzUCzR0e7JBumq43QJBoCFB6ktZ+IMPFQ3Fboc/9mIDtaKhLznO/kPBM9kbBm
	 Hpi5Vy94dJaqaQQ4+fnGntUlgnZDvjqdbNvPaxTIeZDc+pmBk6qNhdzKD/a/4C4+Gc9Uc
	 JN7Rc4/ZNvcDRhvHMNtscbw1F3gc1X3Aunaw/S23oTndR3IohAaDpp8UzYY+5KQAp5g==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793809480;
	bh=iwj8qD50w8Xeyaej9HlfaTT8RIZQVfAdisjRB7sGos4=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Mcoe7DB3ETxPu9ZGruGFSReuLySp+kXV+a2gvdBLriHjDBU481Io9RmJ2WlAg/x4Z
	 efSjzM6lS9JFfjpQeZVguiIryRRHMVjo9CcQPCBP7FSdf+7T8JV8Zg4MJVyQXfZR8+
	 82y86MQhlNN880PTHnSbYtYvswuShpf3G30NC+DMg2banAKyxtPOlCTDyXnhj1UT++
	 Y2SLyS32ZymS2tULSL0Z1lUQYMMHXnJK2N42cvdt8BqK2ktq3eu8fbWqar10tHK8gu
	 r81ZmJj9gRla8hoOx+AK4iTX43sUDVOFspdv8j+39UxVVAxxUQwC7zSCCR6yB8qMgf
	 839sXWtGX5wrA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3F60980C0C;
	Wed,  4 Nov 2026 16:24:40 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 877E4A10
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 16:24:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8381A40653
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 16:24:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id e0YDLGfIftZK for <u-boot@lists.u-boot-project.org>;
 Wed,  4 Nov 2026 16:24:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 988D6404EB
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=5.75.144.95
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793809477;
 b=J3L8M8MSVMzlrBraGUXggE7ksBpp1PzJ7S0sCa/aPQvneDUgqTKyIwntSgyARaXSpxzC
 951IXXJjKqRKRmZhgsSQnLnJQGqXxJLE4jY9yZhliM0FcKR2kPC/Ik633UZaLlLo9WmUM
 oP+ON+4rkR1t7zB2iQvK03PZc+sph5PJNaTyxTG+pG7bY0+jRPBiCA13VYk9BYOC/XApk
 u0HDs+csHoQv9prNW0t0KE6MmbDM70DOZocUX5zFfNvWR9Obp7BNZAc0v2K3rauFhkMhK
 dp6hQZlwJjmuUUKN+eLE+pYVm2cJOEzClSCgjT2tzLuQ/mr+rgPfwh5a5b3mxHMPPpw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793809477;
 h=Received-SPF:DKIM-Signature:DKIM-Signature:Date:From:To:CC:Subject:
 In-Reply-To:References:Message-ID:MIME-Version:Content-Type:
 Content-Transfer-Encoding;
 bh=iwj8qD50w8Xeyaej9HlfaTT8RIZQVfAdisjRB7sGos4=;
 b=nCx4omn8SeSmqs/+/l8HtU6NOhBcrDELQ9zXUruqTkGgOL3v5ZhxGHE5r46Ju8CYLg+m
 hRB4saphB+mXJN9kEVFN9cSVgRAY3Oe8Dcqmmq1kdF+AVQiz046y38pcsxM8zN/xPm58t
 ol+wuiAGwlQfWnYL1oxC0PjS+y9lWlD1p2R4suPeQNTIagadTMJXer4tP2dPP8WB9VvyF
 inHVWxUkkHWU8piU2QEZ+H7VtM+R3d6FJPmjjwLMCVKspsI7cirlZZHj4bGByuoEjpKav
 SeLtPOaMQlDd0hh5o44a1b9BSKYAbLDyhmr9X7WJkIYva8xG82X5/K/3UnwCTJdnjjQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=mainlining.org;
 dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=rsa-sha256
 header.s=202507r header.b=WFBiZQ+f; 
 dkim=pass header.d=mainlining.org header.i=@mainlining.org
 header.a=ed25519-sha256 header.s=202507e header.b="/+osFSoU"; 
 arc=none smtp.remote-ip=5.75.144.95
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=5.75.144.95;
 helo=mail.mainlining.org; envelope-from=brads@mainlining.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=mainlining.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=mainlining.org
 header.i=@mainlining.org header.a=rsa-sha256 header.s=202507r
 header.b=WFBiZQ+f; 
 dkim=pass header.d=mainlining.org header.i=@mainlining.org
 header.a=ed25519-sha256 header.s=202507e header.b=/+osFSoU
Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 988D6404EB
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 16:24:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org;
 c=relaxed/relaxed; 
 h=Message-ID:Subject:To:From:Date; t=1793809473; bh=iwj8qD50w8Xeyaej9HlfaTT
 8RIZQVfAdisjRB7sGos4=; b=WFBiZQ+fEtuEMSi8r6ewSTH7pU7LqgjM6djLapy3JyGtD6l/We
 suZkFkEKrrTTFVxoWQe6Ff2gxIaMFh+bdsuao02AgfGDvRVG8PoWIa7raeZDJE5JbqfrPYTBii8
 XVOhy5d17B1d2EBuvPALLxx+McAjutS9ANICRaPP/HVmPlfuCtzt95XJTeFVSoUmNTkdxV9CyUV
 ErzQZBz3SctPN07ZUfhBt0NaIoEOYq7ArsMi+dm49aZ90s7Jgw73Is7mLw4SP3lry2q3rYwSvS2
 bIYg0ZDp+O7cUnC3bmt+rGH8YtypACksPcQ1HBLV3VkkcshU7lN3hqUhxF7evcupjRg==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org;
 c=relaxed/relaxed; 
 h=Message-ID:Subject:To:From:Date; t=1793809473; bh=iwj8qD50w8Xeyaej9HlfaTT
 8RIZQVfAdisjRB7sGos4=; b=/+osFSoUuc0qnO8M2V5GUYPj4czB2hKY1kLqOj+WFurnc/bZIY
 oQeFFaj2I9bJhzlK7iNzITifkySCu3hWdBCA==;
Date: Wed, 04 Nov 2026 16:24:34 +0000
From: Bradley Morgan <brads@mainlining.org>
To: Tom Rini <trini@konsulko.com>,
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
CC: u-boot@lists.u-boot-project.org
Subject: Re: [PATCH] MAINTAINERS: Update my email address
In-Reply-To: <179380922199.29991.11743513763065873100.b4-ty@mainlining.org>
References: <bd82ee029f9df32b85f4a1c90016fe98852ba92b.1793711640.git.chleroy@kernel.org>
 <179380922199.29991.11743513763065873100.b4-ty@mainlining.org>
Message-ID: <16ABE709-948B-4404-89C0-B8769A8CC237@mainlining.org>
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
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 4 November 2026 16:23:06 GMT, Bradley Morgan <brads@mainlining.org>
wrote:
>On Tue, 03 Nov 2026 15:03:07 +0100, Christophe Leroy (CS GROUP) wrote:
>> Some people have reported christophe.leroy@csgroup.eu being stale
>> from time to time.
>> 
>> Change to use my Linux Kernel address chleroy@kernel.org
>> 
>> 
>
>Applied to main at u-boot-ppc, Thanks!
>
>[1/1] MAINTAINERS: Update my email address
>      https://git.u-boot-project.org/u-boot/custodians/u-boot-ppc/-/commit/be7b24b50d13
>
>NOTE: This patch did not apply directly, I fixed the conflict:
>
>--- a/.mailmap
>+++ b/.mailmap
>@@ -41,6 +41,8 @@ Boris Brezillon <bbrezillon@kernel.org> <boris.brezillon@bootlin.com>
> Boris Brezillon <bbrezillon@kernel.org>
> <boris.brezillon@free-electrons.com>
> Casey Connolly <casey.connolly@linaro.org> <caleb.connolly@linaro.org>
> Chen-Yu Tsai <wens@kernel.org> <wens@csie.org>
>+Christophe Leroy (CS GROUP) <chleroy@kernel.org> <christophe.leroy@csgroup.eu>
>+Christophe Leroy (CS GROUP) <chleroy@kernel.org> <christophe.leroy@c-s.fr>
> Christian Kohn <chris.kohn@amd.com> <christian.kohn@xilinx.com>
> Christopher Obbard <chris.obbard@oss.qualcomm.com>
> <chris.obbard@collabora.com>
> Christopher Obbard <chris.obbard@oss.qualcomm.com>
> <christopher.obbard@linaro.org>

Ready to PR, let me get things ready, thanks for the patch.

(I'm kinda excited to send my first PR off(

>
>--- Thanks!

--- Thanks!
