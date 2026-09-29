Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B95DCA5FA1
	for <u-boot@archiver.kernel.org>; Tue, 29 Sep 2026 00:32:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A5CF160707;
	Tue, 29 Sep 2026 00:32:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WWaLSUIQB8vQ; Tue, 29 Sep 2026 00:32:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org EAC26606F4
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790641956;
	b=c0TvwzxaoiXZWDQ98R9d0e3z1/Ux8xS5Uf2/0+Ps0efTlqy9//X24+gTkIT7ur2T4OjK
	 0V2TOFuKMQT06bUfFN/Thd0dws7Yk7grLDxvSXopBTQZvJ/rqGsVEKjX+hbSWqUSDj8Bg
	 1ixWE/1Bgmt8yiJ8P/OsOwjq/eIIpefokQgYOFQgTQGho4bYK2K8SPqlZZA62vMw6Hp49
	 byK4ufKp5XLXP9Ox3jCZaCSTLHHBP5aoW5spSZZQ8+fw5trOsLfnPZ33XIXFk9ujy1Thu
	 iI5eS2qW9TXWfXjsOEtt6SXTQ/DeIjBlMSCLWUO8J1Mkfj4NK7F9U689rhOg8pNFBRw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790641956;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:Date:
	 From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=mmzV4ClZQDNe0o7Zi0C8KDQtaD7pdsn9gMNw8rvY/Ew=;
	b=jvTUe2G22pC0PYhAqE3dXtoRkjyTnNasORUUq6tK7GGaqMgZkBV5zVdJu9g18p+Psmqs
	 hyQA55TmVedBd5CLbpZuvnIuCB0fG7G7IxB55aUkg1+epPJJZwploxYaYfXqnQxwaWVdu
	 04dquGfPo03bqcj4sbQWjw0CUOGQrQV4MZsKeVJO7UtS5HIH93satuQWgRqbuMWW1ie4i
	 mU9WBfSwh4cHyW0Tm7da26GWdaCsuWxnIWfHaTz4/my9lYhIQV+wnzXUSHXcVPyvm5wJy
	 9/57Tf5TJY/vRxLcJaSHlbhgF/3cLmav4+R5FNZ/13aqFeYsHyCgFdGBBx9fxtu8qRA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790641956;
	bh=mmzV4ClZQDNe0o7Zi0C8KDQtaD7pdsn9gMNw8rvY/Ew=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=XusVmtomhDL4nXe+VO2j97+8ifdgGEcVjGHrwlKzoSgofyK2SZ4/M+goYq0e+/G43
	 7x0cDutK6e1z4muPRZp5Ubt1012OgWw2cxN7iLB3tQrinHeQLsLqGtrdCgF0U2EpPe
	 K6r1mXsBY4X6yX2n5FnsZygz3EFhaXKNAS52FWOkPkgX8+yyFNAC95gtC3TQLlyKwr
	 yywo5tip56/kT6IJOSaHG26/GXAA4W10UVkZEEBRtLu7wwKUR6DQisPl6JY9haCPDl
	 xsiAsFQsMuciu0aZPJh5qM5wm3v0qXvFWtzpNZGhvhFtPImBrH6Q3HjrAZ4BO/9ohq
	 INbUpxmSq30dQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id EAC26606F4;
	Tue, 29 Sep 2026 00:32:35 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 0022132A
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 00:32:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id DABBC8088A
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 00:32:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id P4PdS4lAFaSz for <u-boot@lists.u-boot-project.org>;
 Tue, 29 Sep 2026 00:32:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 4732980851
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a07:2ec0:3002::65"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790641954;
 b=R+bvcJ4dID5LPMGc83XaE0oFs1v/AOxdPGyXFgpin09H3QXRRCe0gzeQYA/Ix1GQ9wGz
 7aqK0Pix93jpJ+5XlJyp8eOBonx+ORNo8jHClyQuD/H6fKcsoEqhFjsjgXFLEgCLxObI8
 nSGAFRxQYnSNudwHtZ/B9PBgTH8I86MgSw9CndYfSFXJSvXjQnhMthkgn6BILwK+M6/FY
 bxp6r5GZAO+f0+Mpgn6VGjzxAev0UzLxnHflelUsxbuAj8Eh3CZQa2Y4qSFGH2pB7P53e
 oajo8wHfiwAOqTIq+EX0OpxpzMuJlQx/Nzz5PDtQBpp4XirrRSXLm/m9smA26evK2BA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790641954;
 h=Received-SPF:Received:Date:From:To:Cc:Subject:Message-ID:References:
 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
 bh=mmzV4ClZQDNe0o7Zi0C8KDQtaD7pdsn9gMNw8rvY/Ew=;
 b=l2itABcFymVErQh5ecpLoax7+B8B5SErCcCNeFqXx/5StTadsZtTHmupp+K56FLi5nKI
 hVszioY2pcasoCotXpIEwTonyGOVg+fuRwGXnDsOvDZXbM8N2lyDxTMvYdo8ZSxRCMw+l
 FAlsglee1HE12f8EYChoti433Oy5819rdcOT66wy/uMBXj3ZUdHrVbzWZx8/j8j/jTy/S
 oTfimx3bAyzGkAb//ljF0R0bmlefBmgl8Y7pZIC8f3cb9jY5PJeyl7bSH4p7EoopK+wPx
 lUouKYX7gFjtWI7iwA0MBsUu+eqayxybyRDDbrBbIvxkI+P8MpIWNx4J+jMBjJN+WnQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=none header.from=makrotopia.org; 
 arc=none smtp.remote-ip="2a07:2ec0:3002::65"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a07:2ec0:3002::65;
 helo=pidgin.makrotopia.org; envelope-from=daniel@makrotopia.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=none (p=none dis=none)
 header.from=makrotopia.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org
 [IPv6:2a07:2ec0:3002::65])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 4732980851
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 00:32:32 +0000 (UTC)
Received: from local by pidgin.makrotopia.org with esmtpsa
 (TLS1.3:TLS_AES_256_GCM_SHA384:256:X25519MLKEM768) (Exim 4.100)
 (envelope-from <daniel@makrotopia.org>) id 1xBLlm-000000001kn-1XKT;
 Tue, 29 Sep 2026 00:32:30 +0000
Date: Tue, 29 Sep 2026 01:32:28 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.u-boot-project.org
Subject: Re: [0/9] boot: add imagemap on-demand image loading from storage
Message-ID: <arsHHMG3icqe1WdB@makrotopia.org>
References: <cover.1787272661.git.daniel@makrotopia.org>
 <CAFLszTixHT2ZLo92bURLbzbCjyTO1B1SsRkBXhN6FMcBxWhTWg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFLszTixHT2ZLo92bURLbzbCjyTO1B1SsRkBXhN6FMcBxWhTWg@mail.gmail.com>
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

Hi Simon,

thank you for the extensive review of the series. Meanwhile v2 had
already been sent and Tom has already picked it into 'next'.
Apart from one issue (see below) I've addressed all correctness issues
you have pointed out in a follow up series which I have sent now.

On Mon, Sep 28, 2026 at 09:13:53AM -0600, Simon Glass wrote:
> Hi Daniel,
> 
> On 2026-08-23T19:12:43, Daniel Golle <daniel@makrotopia.org> wrote:
> 
> > The first in-tree consumer, a bootmeth for OpenWrt-style FIT firmware, will
> > follow as a separate series.
> 
> When that comes, will you be able to add a test for the bootmeth?

Yes. I've got that planned but it's not done yet. Compared to imagemap
and the dm-verity integration (which are both covered by unit tests)
the bootmeth by itself also isn't that spectacular ;)

> > boot: fit: support on-demand loading in fit_image_load()
> 
> Related: patch 6 adds a struct udevice *imagemap field to both struct
> bootm_info and struct bootm_headers, but nothing in this series sets
> either outside the tests. The FIT hook is dead code in the built tree.

You are right, that is the gap the bootmeth series is going to close,
and until it lands the integration is carried on the strength of
out-of-tree testing, which is not a good place for it to sit.
I would rather fix that by getting the consumer in than by adding a
synthetic caller.


Cheers


Daniel
