Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49EE4606A335
	for <u-boot@archiver.kernel.org>; Tue, 17 Nov 2026 16:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=1Ik9ckmf;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IW9FJ5rV
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 242BC6090C;
	Tue, 17 Nov 2026 16:12:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id L8idCvhfSNce; Tue, 17 Nov 2026 16:12:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org D075B607E0
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794931959;
	b=VcYWcjtnx8RiROwaTNtpbdHm0fzLUb8xGtfTB6CNod9ZoCLUewoF6TJKkz3LDFNbwASk
	 0dk+w/JvItlKvbhkyicOePtLeZymsyTbUISbZ3FK+hyxa6gBe4uLATzi+fEum8a3Ueq+j
	 NUb/bCKCDa+pzdNaABl/25oN2YX8JxSHezZE6pLc1M04Uzqtqh/ystK1GTtDURd4wZV+u
	 DzU+K63RRXBiV6baZ2+ig7Dr4ksSryDfJmIkX0ulJAqAiRZbu/HXV/mJA5dPphz+spkje
	 ObYXaAJuh6xp5AVm4XmGyVJ06sg/VBRJEgKF5zGK1r7Ie9q9oHXKAzOfBaIZchSm9Rw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794931959;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:To:Cc:Subject:In-Reply-To:References:
	 Date:Message-ID:MIME-Version:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=iSnngQO6py3eiudMbMbmVi3qMwz/+fMxTKArMvLxN0U=;
	b=NHNhs2owIewlgqWn7Qyp2+ng9V2Bxs5e+2P2DWXXFZj7RYgrHOW0q+urkFRBK0rNFndv
	 r8fKVPgfb30CX3QPET8BSatyhfraXfCnH5b/MrUM2YJ7TiaPZyabGp4IYxzR0KK5Niu+2
	 gyLk3jG44ajv6VAD+Gk0unnTp2fBB6Lafx/DbMupEV9OyUbkr3BsnwNMJEgxWIQENL2qY
	 eCcAwb/DlUwm6I7En3ii420ANp61YdaO0388ZnSVeJ5P0ZQnDj/1bD2nWX81zxkvOrMJp
	 9sa/20pKhgnKa6rWrWeJVLsHGENwQV/hdocl6lxzqf037VNWGPRKb05HFlo2PcpnWfg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	dmarc=pass header.from=kernel.org;
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IW9FJ5rV;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794931959;
	bh=iSnngQO6py3eiudMbMbmVi3qMwz/+fMxTKArMvLxN0U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=1Ik9ckmfUQh+DMZFJ0I5Rfmy2NXCA5UxIgRue0SbvzOhsT7m0dNob0CJzgjQH5ZMi
	 VbsdGNAcjUzjCrvmz0dvxi54+1lj2mBUW8UzE2JYo5RWvA5U7NW2ol0PRetMjc0i3Q
	 GzFbPiY4hvUSz0P8qyNoIAAsEsLhXyenrIDh0KR8VfP18rIHrNFyRpaVHDTGicAIwv
	 g5QryYgpY4LO2SbykgwpViebCLYbu/6+FG9G5TOcd5sljCKVJRstSeiRtRMP1dMSO+
	 H/gs8hAg8RgEUvf0bHOvLjH6RKqcHIwvm4zTAwa6p7TMzsJ98NQqcbOIXbhMGrvXcT
	 qcbsLrOCobi6g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id D075B607E0;
	Tue, 17 Nov 2026 16:12:38 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id A5B2EA0E
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 16:12:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 8C1DC607E0
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 16:12:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6bPfPMIvrlec for <u-boot@lists.u-boot-project.org>;
 Tue, 17 Nov 2026 16:12:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 943EC607D1
Authentication-Results: smtp3.osuosl.org; arc=none
 smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=mkorpershoek@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=IW9FJ5rV
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 943EC607D1
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 16:12:34 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 531696113B;
 Tue, 17 Nov 2026 16:12:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 898A81F000C4;
 Tue, 17 Nov 2026 16:12:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794931953;
 bh=iSnngQO6py3eiudMbMbmVi3qMwz/+fMxTKArMvLxN0U=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date;
 b=IW9FJ5rVIB/7qikI+TXnsfuSVY4hdwgfl7xkdvcbYFQ6wTeoOzY19ps+KWKlod9s4
 AvHxDvp0PMoZ63v0RA91VS8xXgALwonwBCEaOyjm/BfUcnhGK0sCU3LbjJ/hxJdlnW
 c6JOdELOxlEQh6VImuXuoxWQSYEJuWUwLmDpYMAIG2XYsMeJvWXuLnOzbUYgV5GNHE
 CJuvhfwGXJQ846NQQIJHFoBi4ZZt1y/LgoNYZIyNkpjXn8+6RYNOjPUufp5r5gK6Pr
 8NJ4txi+5hMlWVL5th5RZDa6j9SHoK495oro660Xi7DyM5Zb11NBB4S1EUyIQwS28h
 QmczfR8z+D8eg==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Ana Bobillo <anabobillo3@gmail.com>
Cc: u-boot@lists.u-boot-project.org
Subject: Re: [PATCH 1/6] usb: gadget: composite: bound ep0 requests to the
 request buffer
In-Reply-To: <CAJnxHsigzKsFzHFwcfQej2rWLZaQBmiJv2HYgjC7rVBUxS-4Ng@mail.gmail.com>
References: <4bdba9dc-0c21-4e33-8f20-2c0a7ebba0d6@gmail.com>
 <3f4477b0-1aa7-47f8-97e6-3391dce81d94@gmail.com>
 <179492784365.252888.8046542995168458123.b4-review@b4>
 <CAJnxHsigzKsFzHFwcfQej2rWLZaQBmiJv2HYgjC7rVBUxS-4Ng@mail.gmail.com>
Date: Tue, 17 Nov 2026 17:12:30 +0100
Message-ID: <xhkdby0arphch.fsf@mkorpers-koolstof.csb>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Ana,

On Tue, Nov 17, 2026 at 10:45, Ana Bobillo <anabobillo3@gmail.com> wrote:

> Hi Mattijs,
>
> On Tue, 17 Nov 2026 at 16:04, Mattijs Korpershoek
> <mkorpershoek@kernel.org> wrote:
>> Looking a bit more, I've found the mentioned one but it has a different
>> sha:
>>
>> commit 153a2d7e3350 ("USB: gadget: detect too-big endpoint 0 requests")
>>
>> Can we please update the commit message?
>
> You're right, sorry: 36dfdf11af49 is a stable backport of it, and
> 153a2d7e3350 is the mainline commit. The paragraph should read:
>
>   Linux closed this for all of its composite functions in one place,
>   commit 153a2d7e3350 ("USB: gadget: detect too-big endpoint 0
>   requests"), and barebox carries the same check: stall an OUT request
>
> As I wrote to Tom on 10 November [1], I am not sending new revisions of
> my series, so if you apply this one, could you make that change while
> applying, as with the Fixes tags on 6/6?
>
> Thank you for the review.
>
> [1] https://lists.u-boot-project.org/pipermail/u-boot/2026-November/639858.html

Now that I read the above thread, I am quite unhappy. It's disrepectful
of my (and other maintainers) time to have not at least done a
human-review before submitting this.

If anyone else has any interest in getting this series merged, please
help me review/test this. It won't get merged if I don't hear from
anyone else on this.

Thanks
Mattijs

>
> Ana
