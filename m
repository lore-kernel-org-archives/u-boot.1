Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94523C79F9E
	for <u-boot@archiver.kernel.org>; Sun,  6 Sep 2026 20:13:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1FB594059C;
	Sun,  6 Sep 2026 20:13:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ujfg4OJHPgHW; Sun,  6 Sep 2026 20:13:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 48F6340589
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788725591;
	b=Jt6TILhEZLuAuauiqTai9QohCZTHn/2lIZA+RUnLHinYW8CYoY4caf7OEuV2f0jx1mKk
	 MRc1HKwfowg21H58TOHMXnLoQDG07hsyWyf4pXuhH0bmFJgxyaAVB6rbSagi7d5Xf+A3s
	 TNGKezKW/vSG1UVMizNZQPlYzB+9OW4W1qVWBRP3psQpKCr4ufwrnOUDPTFK+mha9bQ5r
	 oI6ue6f39QqFn7DrPOgkYOwe/f+1BJfr8JMy51TZxpflCIX9neg3ZKD/A5FKS4HR7vE9q
	 Vrg5toN/GB4VdPYD9N72fIgiRbnTikWXvPxH64h7KtUdkZNM6W8Pi+pnRERaTTMqX6Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788725591;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=23Rs7Iw3pwragO2tfUhyxhnS56ZS6Y7xj9TAbv/PPg8=;
	b=rMA/844pI3Udg3sRehFtzkBB0FEDcfKHKv0903TXytmcy7mTVh+E+8YxXfKU0l9kWJ2y
	 lvKlILmGpT8Q4Eu7ZhfcHo+KpjZ40AokRWutxRbGghh4xzSMOfekHO+WClf8HzSIWWSPZ
	 zUHm52vB64U+9BKHtKqazlYWvyPtcG5LYTagH75QSPkue0e2B7HBBsRnhz7Jn+f/cjPUQ
	 ne40qRPK7UuRvOkY3l8ZhA3lsLxM8eX2Hy0pKOqFq9k2kvN7G0V3cPieGslSaVo2CpPNp
	 oipt90kK2ySahnT1A8ziUIeF2ZgjbvvtXW3jpFbzYwDWxsChaQCS0qcR/IPhkglvLTg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788725591;
	bh=23Rs7Iw3pwragO2tfUhyxhnS56ZS6Y7xj9TAbv/PPg8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=wph2I6DFm9aFvB+PpglCnaPxpjos+gUbQdorfJ3npcG6vDGJ9xi4Tr7kO6XSdI/jm
	 juAP68F81a54UdxZffc0Lqv+qBnC6vwfe6vbf7bz1wtG1UPluXSTJZQD9zwRU8n+ZI
	 EnTyopbNZwtmwqC1Ti8nKlUDYRjfdFeF6lYS+k5FbIt0TPbKBmp/9M4pWy8lq3xybI
	 zxMnTS+vr6Ut5/5hss5k7kY7E4Xt/zla9rmmJqm8JdPt4eyNrZNIwV/AQjKL6PT+j3
	 dwsx3KSLGIrW80anybDlksMy/OmmtZ5JUJoH8PcJqj9ofNn7B/fIbyrVXBOSofnGTM
	 PJrEKkDD1kJgQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 48F6340589;
	Sun,  6 Sep 2026 20:13:11 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 302BC388
 for <u-boot@lists.u-boot-project.org>; Sun,  6 Sep 2026 20:13:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 15F25807C1
 for <u-boot@lists.u-boot-project.org>; Sun,  6 Sep 2026 20:13:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2YyFy38TW5UZ for <u-boot@lists.u-boot-project.org>;
 Sun,  6 Sep 2026 20:13:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org DC1A480733
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c2c"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788725589;
 b=Kaa2Oiyshf0LexluE8JSPQ0lIYGSwK5SQaEbTF1vKZgimWcD8u+D5ymepniFXWxeLwMj
 b9wwhm6xJ10SmZ5rh8jLU8tSFnk3Qfy7u8445f5g7Qst2gzMriNLSfkRvc6VFH2v3DHjc
 Hzs4Gvuag2QP8LcgN7q7zoBh5aMBxguw8k4KF78HwbW38N13ZDdcSIA/VN5EGB97Vf2ul
 WBb+jGrbBueTqlmR6Qf5yTa/BRtG5Hox8rezdAGjPL7ZZO12kbvuCuUnxC2cRCH4OVtSZ
 WeOhNZZ4gFSeXD3LEmPXMPQ85hAiMeBgnOOKLxV3qCuvW0xqpXne+MjYfJtSuq++ZhQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788725589;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:In-Reply-To:
 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
 Content-Transfer-Encoding:X-Mailer;
 bh=23Rs7Iw3pwragO2tfUhyxhnS56ZS6Y7xj9TAbv/PPg8=;
 b=MDMqGMx4b3mRJ4IV9yASuGO+DioNb9RKv9zQqEBxLaveFdlUmtR0/xVzMr69zeqbl1Md
 0zxnOWnKb/T58dvvArPVf9pB5frdg9DUec+FFwzIivoOeYV2BaPmjk4YS9gDJWTCqTLQ9
 OQ6ms02cFcJdwCWl8m+jgT/xkgo2w6/+IUwHriwOz+KTbDfST61acxju874e5h9xDGaPl
 eQSG7huZIWduaf0tPrEFksstpg5NZGPv0Tviw5vBHJS7xinZkDr1qaIvVwWlJrvrZEZns
 gEpa0c8U5NNJ13sdTU9DziabNSCPNLHWmiFxZA7mrmmbkC7FCKkwA/V8gLn+aoBTmAA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=konsulko.com; 
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=Dh+c5y9O; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c2c"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c2c; helo=mail-oo1-xc2c.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com
 header.a=rsa-sha256 header.s=google header.b=Dh+c5y9O
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com
 [IPv6:2607:f8b0:4864:20::c2c])
 by smtp1.osuosl.org (Postfix) with ESMTPS id DC1A480733
 for <u-boot@lists.u-boot-project.org>; Sun,  6 Sep 2026 20:13:07 +0000 (UTC)
Received: by mail-oo1-xc2c.google.com with SMTP id
 006d021491bc7-6aaf3f54dbeso2984688eaf.2
 for <u-boot@lists.u-boot-project.org>; Sun, 06 Sep 2026 13:13:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1788725586; x=1789330386;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=23Rs7Iw3pwragO2tfUhyxhnS56ZS6Y7xj9TAbv/PPg8=;
 b=Dh+c5y9OnFOIn857o7RwsBP5sxQ8z+csFgXRmIbCBMmu13sZE2d2ydS3r4gFvWARGP
 gnoKuT+kTbVSBRc/xhGZzUSC0/Uppp2TEVYD2K9RS5akvrnwzLo1O40H8iu2s2LGOu5y
 q/cynPwoFlVRMx+0ELEkkfXgbOCl4cRAfloxQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788725586; x=1789330386;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=23Rs7Iw3pwragO2tfUhyxhnS56ZS6Y7xj9TAbv/PPg8=;
 b=CLWxE+GzN7TdcixtHTTgJ0z2GKgEMw5J1clevsQfNMANYEZrl5b7xI2tiJqOMqw81K
 spigbPWTnWupz4rKC0PWebG7aYPhATdaXqy6SRpCU24DKvJPDqgmIZsSS3w8KiJQBQ5D
 0w8yJEcGftF676yoP4mU9pV22uBmXOhIIexdjK8WjEdB+W967YCQgmMR3NEsGgOgXQyW
 3VihCSxaCNmzCXWJgF9bd1a+Tz2b8vXmr0I/f+EKBkbcAUqyR7kwaCDuKuLpYOqLB4cP
 EeZPd1EisOrMsz+mr7+zqlD6W7BMlMvXs9ayn7pbCcXmkA607zeTyBfpWtz4d33cgEok
 KUjQ==
X-Gm-Message-State: AFuF++nuXtT0Qmj8iYLnPX/Snx3BmHog3vStLwgKXIwoe4+l3dqIlw/a
 OY65z0fO1Yjhtu6Vyt0Lwmn6/+nul6dRaAfZyjmQcMX3f5EhWhzweuG06UHYxU9XSpQ=
X-Gm-Gg: AYBFou1PBThTM9cE2GujXqQppORHEXgtO86lfyfHfmkUhov2Kzcj2h4yTEavcTiWRO9
 dvYOvGUXpoOkIs7PJ1L+lA5JpkRHjbzQLG1QEBOxfuQOrmtWMoTE4GfJoSDbZQDWyuPt1h7lf15
 Nt+np4SBDUcqocyMDPOfJmY8MpNCN3E9NV/7ZcFBpxtmn3Fhr86REZlL9TB5dhTXqWDId07j7Eu
 5+G9T5Phl9Z0nggDSSXq+5ChRN62CN+k0vOP3c9SwdnKbPzwkUcv2MraazBjqW1UOao+I5yLYht
 vYv2fP16/iIa4FcIT2ZSDfAGrWA3b2RHH6XS+9cbZOUYlXWoz8hbXL3krxTuCtGNtj97eV9c1fN
 w7T600Az0hOMI35c3Q4I/cA+nPU4jvF1CtQRNAtRgB6xeofw4+JS6DbpZHixjTUVyJaDq7gJja/
 KUoS2TIAm3+lYNXpVJIR/Cha4cU6R1YBkkjOr0XMTRkQRSBV3grek0GpzdbFQAApp3SmrATul82
 V8M5y6fgKUxwL7pckESWCZ3j/E2BKirZHaiSfeGoCv2njqa3JNWw6p0rru9HAb+7wNfy/d5iEB1
 itSaeRdY
X-Received: by 2002:a4a:e916:0:b0:6a1:47c8:c86 with SMTP id
 006d021491bc7-6b6fb4e7a5fmr11531224eaf.10.1788725586288; 
 Sun, 06 Sep 2026 13:13:06 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4762bb39439sm7039074fac.9.2026.09.06.13.13.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 06 Sep 2026 13:13:05 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.u-boot-project.org, Bryan Brattlof <bb@ti.com>
Cc: Vignesh Raghavendra <vigneshr@ti.com>, 
 Manorit Chawdhry <m-chawdhry@ti.com>, Vaishnav Achath <vaishnav.a@ti.com>, 
 Jayesh Choudhary <j-choudhary@ti.com>, Apurva Nandan <a-nandan@ti.com>
In-Reply-To: <20260829-maintainer-fixes-v1-0-e4e03971e14c@ti.com>
References: <20260829-maintainer-fixes-v1-0-e4e03971e14c@ti.com>
Subject: Re: [PATCH 00/14] board: ti: update and correct files MAINTAINERS
 entries
Message-Id: <178872558496.3634654.4200111512353964189.b4-ty@konsulko.com>
Date: Sun, 06 Sep 2026 14:13:04 -0600
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

On Sat, 29 Aug 2026 09:34:18 -0500, Bryan Brattlof wrote:

> While updating the check_maintainers_files.sh it was noticed many of the
> MAINTAINERS entries in board/ti/ are out of date[0].
> 
> So this series aims as trying to update all entries by splitting each
> board into their own block, sorting the F: entries, correcting any file
> names, and finally adding any missing files I noticed.
> 
> [...]

Applied to u-boot/main, thanks!

[01/14] board: ti: sort file entries in MAINTAINERS files
        commit: 4231d50c067003169cfed53b6dce753211aa46ed
[02/14] board: ti: correct names in MAINTAINERS file
        commit: f1a98de73e3a8e9ceeb93e04ab218687648fd5ab
[03/14] board: ti: am62x: split board variants into separate maintainer entries
        commit: 81e8aa8d426efc5f9ba87af4cf79846b0bc96863
[04/14] board: ti: am64x: split the EVM and SK board entries
        commit: 8944fe91356188e4caba14421b22083b2f453345
[05/14] board: ti: j721e: split boards into separate maintainer entries
        commit: 5a08a113fed2261a748f574aeaf2c8d769a94794
[06/14] board: ti: j721s2: split boards into separate maintainer entries
        commit: 7ce170d9507d2add5ab02182fe1c2cd4149ace32
[07/14] board: ti: am62x: add files to MAINTAINERS entries
        commit: 774e11aaebd373979d4525c66a052c9c32bdd31d
[08/14] board: ti: am62ax: update MAINTAINERS entries
        commit: 2954465b7de8588a2c3b64ae4c0dbbb16abd52d9
[09/14] board: ti: am62dx: update MAINTAINERS entries
        commit: 7ee8164bd0682e01a7bfe315d81ac0929051c3ff
[10/14] board: ti: am62px: update MAINTAINERS entries
        commit: c305e0cd6155c932202e290a032491161df6d803
[11/14] board: ti: j7200: update MAINTAINERS entries
        commit: f2e95ad4b02afe8a671cf2905f111d708c4e4b46
[12/14] board: ti: j721e: update MAINTAINERS entries
        commit: 5579e96029bbe5029cf2975462ba477774bffc73
[13/14] board: ti: j721s2: update MAINTAINERS entries
        commit: f6959b909fa564bfbb78976c7e3a82b3fd8776ab
[14/14] board: ti: j722s: update the MAINTAINERS entry
        commit: 23c2aedbd786f7fc13b4b8c11b1194b19d51c741
-- 
Tom


