Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDEA4606A334
	for <u-boot@archiver.kernel.org>; Mon,  9 Nov 2026 00:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=SxfxLy1+;
	dkim=pass (2048-bit key, unprotected) header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256 header.s=s2025 header.b=EyJH4g8U
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 836EC80E28;
	Mon,  9 Nov 2026 00:59:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id y8THTBZkg8VZ; Mon,  9 Nov 2026 00:59:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org B3ABF80E1C
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794185946;
	b=Q0iy9+mrMrmRHRTyvshGvJKrksQ0vs0Tstn/D/ooUbY2ZKmF9KoJU3NJQf3TGVTJVtF7
	 tqV6M0Ywtwhp4oyVlaQJpha7Nzkkr67wMl0I2FQqicyWDtnwLZzPJy1yEyooMVv8PT6Xs
	 GlQJwYSASEGvJ8bLFQWaoKmcxsIGSCp2swxOWojwte9J3hZkSvmmQZnmCH5VHGwm8AEKv
	 EOXrfAM9jhxNV0ZpBj3ity7Zdl4S7Omei+cRupYX4+OF2XoRlaUpTLZFszkUdA8d/d23e
	 wTnUJ0Wsv1fAu3U3EhFrTl5B+0w4JtDRgaNDcJp7IHhDUwPK2HbGN2EMPlp9ts/CKaQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794185946;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=ejjhnz5282vhNzVgEouaRGdKjuuYTOQ33ZsMsb46L6Q=;
	b=kXQmqjWIDuA/cFLgybaltuvJtAvuiWpjycpefnQwd0Suvdk2f/PDpCElck1PAtgTV8y5
	 aVeCBBZCkgtqc8yx7Gtd//ib3VxC9s7q0BFsgGVSejBU/jW5y/HnGJ6seLGmK48CTF0+z
	 wZRZJUAaD9HtlMxrTb+7ZvS2cYfFqezA/I4TymuVCHRBZTT2Ra1rwHlqdQdr/q86ELKAf
	 AkJGwJXyZa5SFm8IEnYQghwWA3G7WQPbDB9EuasXiXEnK5SxMo3Vf+nEjIffdn8RTTedW
	 NjISGTIQ7216JWe9Ucslg1lwBkCkDGsa9bs//rI6C5ocvL0u/HQHTGUxK90PEI9PJ2A==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=freeshell.de;
	dkim=pass header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256 header.s=s2025 header.b=EyJH4g8U;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794185946;
	bh=ejjhnz5282vhNzVgEouaRGdKjuuYTOQ33ZsMsb46L6Q=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=SxfxLy1+BvkQKxlT1GYgb8GFL27oGFeIcfNetnI6RQMzooUf11AF7hLyZK2JhjC0k
	 g9pYAZzOShSA0LEG2nwoPa0u8MjmcOB8RnKr4ixc852KmC1B+5v9Gpajv4H1TVRunL
	 Ngm3wYT0UoNIpfYyb9HiajGDhH1T9X+0EH4Pl6t4zotmwRQjVw5or1Q554o6Z+GIxN
	 PUVav2KF67lWA7gsQX4sOFqdCE7DCXJXkZPome8rVCvWPAVgO/z98RqqRjtIMblgJ6
	 AJv57K3i+BlZP72javGErt9iyCLng+qNR9WJ+OR96ABtPwmZKXKz7y57iBCZM863E4
	 PhX3dBcj6nf2g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id B3ABF80E1C;
	Mon,  9 Nov 2026 00:59:06 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id E923C1A6
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 00:59:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id DB24C80E13
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 00:59:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lWXRX5QRMgpq for <u-boot@lists.u-boot-project.org>;
 Mon,  9 Nov 2026 00:59:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org BEE4480E1C
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=116.202.128.144
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=116.202.128.144;
 helo=freeshell.de; envelope-from=e@freeshell.de; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=freeshell.de
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256
 header.s=s2025 header.b=EyJH4g8U
Received: from freeshell.de (freeshell.de [116.202.128.144])
 by smtp1.osuosl.org (Postfix) with ESMTPS id BEE4480E1C
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 00:59:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=freeshell.de;
 s=s2025; t=1794185918;
 bh=ejjhnz5282vhNzVgEouaRGdKjuuYTOQ33ZsMsb46L6Q=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=EyJH4g8UwWqNoWbzjo9k60eOIZw4xjISTX8nOaxfhVnwT8PLdc8Y7AvyHwQ/sW7WC
 276GJsr4SDfWCnOnlGvtkzpmWhj9XijwY/qtaIF31HpCRAEHlA2bd8xRk8WHue0DM5
 hCMyoBCNTkeNj4RBinFImgcicJPn+KnqIq1Ptx7gfdSVPIryYxVvYpsAS4SKkdygXT
 Dh6NsLVuL2rycU+ULzK10sfNOhzGMkc09Y5zT3/d+C3wvu4h5+vXi7Eah2+dSfMtan
 lv7va1noToUaAdpel9OQKS9UzlL113UPk99p0uuHX+06UwBNFxIX7A2oshD8HNeNRT
 dfeFMQ8BXSnjA==
Received: from [IPV6:2605:59ca:364f:d400:1b91:6b30:22c2:fffc] (unknown
 [IPv6:2605:59ca:364f:d400:1b91:6b30:22c2:fffc])
 (Authenticated sender: e)
 by freeshell.de (Postfix) with ESMTPSA id 43A40B220850;
 Mon,  9 Nov 2026 01:58:36 +0100 (CET)
Message-ID: <8229e24f-bc71-4232-b1bb-8cd6c976dd3a@freeshell.de>
Date: Sun, 8 Nov 2026 16:58:28 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/3] dts: build the DTS from a directory outside the
 tree
To: Vincent Jardin <vjardin@free.fr>, Marek Vasut <marek.vasut@mailbox.org>
Cc: u-boot@lists.u-boot-project.org,
 Suraj Kakade <suraj.hanumantkakade@amd.com>,
 Markus Schneider-Pargmann <msp@baylibre.com>, Denis Mukhin
 <dmukhin@ford.com>, Simon Glass <sjg@chromium.org>,
 Rasmus Villemoes <rv@rasmusvillemoes.dk>, Tom Rini <trini@konsulko.com>
References: <20261108155019.1485598-1-vjardin@free.fr>
 <434743b6-17af-477d-a09f-d110d565f023@mailbox.org>
 <avC2OzAeGxqVsJ2v@L30177.local>
 <fdee1975-8f27-45a7-85a8-2405c29e1dfe@mailbox.org>
 <avDgloDmuQcYP7ec@L30177.local>
Content-Language: en-US
From: E Shattow <e@freeshell.de>
In-Reply-To: <avDgloDmuQcYP7ec@L30177.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Vincent,

On 11/8/26 12:50, Vincent Jardin wrote:
> Hi,
> 
>>>> Upstream your hardware support and you won't need external DTs.
>>>
>>> Even upstream, how does it solve the Yocto's and Buildroot's related
>>> issues ? Both did try to workaround despite they are all upstream.
>> Could you apply a patch which contains the custom DT instead ?
>> (using SRC_URI:append = " file://0001-your-dt.patch" or similar)
> 
> the patch has to be redone, again and again. That is what Buildroot went
> through: see [1] or [3]
> 
> For Yocto see [4][5][6]
> 
> Both do hand copy ! config/git management is not convenient neither.
> 
>>
>> What is the use case of custom DT injection like this ?
> 
> For example,
> 
>  - Bring-up. The board needs U-Boot to boot before its device tree is
>    anywhere near upstream, and the .dts changes several times a day.
>    Pointing the build at the directory beats a patch per iteration !
> 
>  - Linux sync. A DT that is upstream in Linux but not yet in U-Boot.
>    dts/upstream follows a kernel release, so a board whose .dts landed
>    in the kernel waits for the next sync.
> 
>  - Board variants. A carrier or a memory variant of a supported board,
>    like the VisionFive 2 8GiB report [7], needs its own DTB but is not
>    something U-Boot wants a defconfig for. The variant .dts lives with
>    the product and builds against the SoC .dtsi of the U-Boot release.
> 
> How to handle those cases + Buildroot and Yocto without such proposal
> for uboot ?
> 
> best regards,
>   Vincent

I've mentioned previously on list and in IRC discussion this topic of
dts source tree names being hard-coded. It would be very useful to have
LINUX_SOURCE_TREE=/path/to/source/tree/linux.git and a Kconfig option
activated to pass to the build for local development substituting
in-place of the 'dts' sub-tree. This is RFC do-not-merge territory and
to prevent abuse no patch users of code depending on this Kconfig option
should be accepted to merge.

I think that it is too fragile to make support for an external DTS tree
as a supported dependency of in-tree boards. There is a concern that
vendors would normalize this and make the situation even more
fragmented, contrary to the intent of having Linux as the device tree
upstream in-tree as a 'dts' sub-tree.

There are two overall topics here though:

1. Everywhere, all over, it is assumed "dts/upstream/src" literal is the
devicetree-rebasing tree location. The hard coded use of paths in U-Boot
build system is technical debt for when we would want to extend this
substituting an alternative location of the 'dts' git subtree.

2. devicetree-rebasing subtree does not share the same directory layout
structure as Linux kernel source tree, and the need for substituting
this with Linux source tree locally is not possible to provide for at
the moment;  temporary hacks to remove and replace the subtree directory
with symlink to local linux source tree are not sufficient due to the
differences in directory layout and missing or conflicting header files
referenced by dts and dtsi inputs.

The motivation to resolve [1] is moot if, as has been confirmed
previously, 'dts' directory name is the permanent location of
devicetree-rebasing sub tree in U-Boot source tree.

However, [2] depends on [1], and this touches a lot of code to abstract
the devicetree-rebasing subtree handling.

I'd like to see this realized but is it worth the effort?

-E
