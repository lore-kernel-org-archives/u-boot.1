Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9CA5CC6B0E
	for <u-boot@archiver.kernel.org>; Tue, 13 Oct 2026 14:37:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 96D7F605D7;
	Tue, 13 Oct 2026 14:37:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9oja-vA1wK-h; Tue, 13 Oct 2026 14:37:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org E4D036072B
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791902267;
	b=nt4CE9LnSbWtKmJQs1J49Sie4bCMgiIXcgp6hp6wBs2sVjt+5+hxpSByk3ojvregkwcT
	 rrZOITYjuhtdrEGBvorilg9UIid1IOUCJtTYFpFB/gtb5NXg4jrbPuBwBPcepphJOHbHT
	 zSlk5evvb7KJqJp66zH/Chn0N/6Ukjs0O7ddORq7T51yPdrQbrVP45Oi/Y6ma2jHovaQk
	 HKKlzLHFpQPp65B0gwBEd57PmourFLLihiSncj7gQLMUXW3DuT+pz7ZR6qC8GfstMTNfs
	 Y1hgqgQnD1Dcc9ifwX938UJvHpQ1WYxyayY0wJl9kX4TIMCdGMPxa2brtKNUFPPk3FA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791902267;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:In-Reply-To:
	 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Mailer:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=Dl4PljFp5Ga0S1YSFHA4odXBPv5lCM1yOStGJ25m81k=;
	b=pz0xifjcaKJbleUUeLX79NrJ6RvUu4ozRPC94WbI+ewFr5t15XZQ6Yda5oxuCmnBNSZ5
	 B+cRQq0YA9xb8+q3MgN/yfWN82mj42AW4UyDJsb1HltScj/rhjwQaqbJstQCKPDA9dQ9w
	 6dyzju0qcUdTREV3iO8y+gmrhzA48++nm+O96xlOAIvw3OB7PiELdtz7q2cVBt5P6OwZ4
	 3CufMQCV9+TSDheGFnQIWUM/rQoYzdEQAQDx7AC9QkiZ3BTtCX8VVaWFoWJW/Wy/BaRWh
	 h5wfu3K75x4NbnQNgju7ZfnxyKzyaLGP8hpEz/n0J5KiPH3mJaUYgAjFKlFNJlJFcNQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791902267;
	bh=Dl4PljFp5Ga0S1YSFHA4odXBPv5lCM1yOStGJ25m81k=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qdVDIIPjtPQW4RoYa6gHz/jBEK5LJOK8o1tzbbgjfb7ACytencb0eCHEnNpbRFeX3
	 qWhmTibb6x6vzDPS41xzRP3XMi2mTVqKeKVGEoNDb7efXxEhLpULIMetIYGia7jgM4
	 zJXLJ6AhjZVtFPdvF1A/TSXlNCPYuB6OoNa64JCOfJMdRIttux1by6fxSx6ipasm4T
	 oFsVPzilcBxhslWWA33v8slsciGwg0hDxncdO5Hm2br1WZ1++65a8KgT4LnqexXzMk
	 7uyr9vwLLmuMwiObWOswdfJvbbgN1yVkutPnNRni3XbVGho5qFXa3/vVJ9unQN8/2D
	 wp43djuQ/HQ7Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id E4D036072B;
	Tue, 13 Oct 2026 14:37:46 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 638562E0
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 14:37:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 557D2402B4
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 14:37:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id X-ZFcp6HYhZ6 for <u-boot@lists.u-boot-project.org>;
 Tue, 13 Oct 2026 14:37:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 8EC404010F
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::32e"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791902264;
 b=fiJCvEPCT5+SN42l6zoIyZYPbbrwKfXQGjndub0c2RinpyJn2KI0yRTfTbbjGI8X8Kja
 rYlbRaYQpD3DA3wq9Vf/tYSeCImyjAit2PCqAS+BGZfMEyXwPkBlFS8Kw17jPgL7CgLlD
 h6tTZj84lqXWp1kRJ8Up/Lc6wQDaSHhLb3NGtqoTMW7BOSy1TtxpzgXdQsGRNYJpFDS3F
 PEovINyl0p0Jf+T4TVnTjJI2xKCPsshUstAeVUb+oAGNaqgv4X515Oe2DjlbVXwB4Zbps
 Rds/y9dZXNY3LrKSu3+zAe4t+XtIcYHszxpPByArbYNSW6QgFV2GEyTYcFA87VOFSKg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791902264;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
 MIME-Version:Content-Type:Content-Transfer-Encoding:X-Mailer;
 bh=Dl4PljFp5Ga0S1YSFHA4odXBPv5lCM1yOStGJ25m81k=;
 b=suwwqancUBRlwCZ3AN/5cxoQ7c1uZR6SfHjhGNa9FqaPZP9RaMW5KAiQw3sxeSkTTo+t
 EpEBQsBE4PVsDoHozhZRA/F1j/zlAyLpxIK6h6BBaasrYe1nL0NSPkrhK+88h1mk+F/eS
 KCm5gXUkNV2gNg5FfuxByR5rklDa9w8raCTwA/yfeywZaLAx2QAQNwTrTHSHoTRttbbpB
 2UU0eWow9kSjDmTehy5QJh3wLWqKiTOEk7amM6QQqD+FD95HZGPYLl0VlEyxqNrl8BVk+
 n+VwP9jcSPvSAm851rD5kiUQ2tWFhsqYCjZI1pOr1GA+sRuCCB1QCfW8DMkvcNXHStQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=konsulko.com;
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=JnXJu+Li; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::32e"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::32e; helo=mail-ot1-x32e.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=JnXJu+Li
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com
 [IPv6:2607:f8b0:4864:20::32e])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 8EC404010F
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 14:37:43 +0000 (UTC)
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-825b40f8a26so1489649a34.1
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 07:37:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1791902263; x=1792507063;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Dl4PljFp5Ga0S1YSFHA4odXBPv5lCM1yOStGJ25m81k=;
 b=JnXJu+Lin6E/TeAw/Q/tfmvwB1UJ3v/8N1g08Jq5aocrSvWpUWL0GaWeWgaJKc7oTW
 1a+UCmDLPLjUAUr2EhHUOsfRfyPvqvlv28dj/8oQfBIBo6duHlOzHmEh1OEcyqrYsDA0
 t/t/+0DcUEZPZppaWd5GFesimW/BXsP8td3+c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791902263; x=1792507063;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Dl4PljFp5Ga0S1YSFHA4odXBPv5lCM1yOStGJ25m81k=;
 b=XnO/A4ZUXyoaeWKTcF27ZIVb2gyeZOIZrvpKstlr+MDqksXdvB6VO9sIXgYmFuv+rN
 9zXg7fJ2aeMPB090GgC7DPRLiIq1ehzgXgLFwCCiLPZ4NJ5hQiY5R1mT0GeWaRNTzn7K
 ScxAViIY/Bjsr35NFewNL1xnZY5sPWDnv8RkY/Bl2dGYXWVK1zawEB9idXEV6HA6Isn3
 pVWVM6TlAO53Q7JMMFkMECHpBCgIpk1VsC0JKo2x5L6DM7Q0+kBXU++EuOF0ziP3A3hw
 zGJ+YVCYBdNRxMJ25Jy5Iu1PtpiSDINb7Rx+J0yRU0ApOiWHxAH298YZ9h3VbRgRPkMz
 EqzQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwadIN1rGPqBE6XHrBarY/jGNIqMXFQxRamdKb+O1Bgh6a1GfqqvUGGto7j1pbarW9xTKxxS+I=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYKGtYdCk1o2N1E3nSvbcA7DVMWHGN/N1Ov15rbRS6klWnk5cWyA
 31FaToMg5Cg457+zr6X7qSTiZ6l4eFPY3oEeWrqNMoW919nEIQ8bd9oONf2Gg+IqS1VecHOwcBN
 b/8XCMTqs2RYb
X-Gm-Gg: AYBFou20Fw2VLJJAekwjIEh84QnykOYUO8XN2/RQqJ4eM7RaiPTopUe9XfaQcanudac
 2ucxFpPDQpG5jW8x8ltneeGS4fa+m5nFb21gagdh8G8Xuq29+JMTtPqOp714ziXSNEnYjY1uUbn
 99SmFKG78IIuhkp8tT9SB1unYOBdVJqHmqef3U0arN6xd5rNIztZCZBwtxkrkai24KJIxS3+CkK
 beS6M2e+i4gvip/33f9e1dNCGQg2304Vws7kCCkCifXx5Vy2uIuo/R33tjMdIWLdTr90kb/2eLn
 zzVCg1KF6Osblp2h5rm9gzfSr4SNYsRzmwC27OY72Lt65vWtQ6i1TtYEmWw7zA0he1PMnxeZn22
 QkhDPi6n/owB2LyLfqqWPbtvRdUDKVDYkgHXGa7hMWCk7eKumQgEMOf+U8uLQMxECIGpOS8MsT1
 zDHoX79SYM4yhpnAOdrcsDbsj/3RYF/sJgUiCSDYOAG5iZCjq5PP7x6whaTXWWpp4lifX7CtsOf
 LIJ1GTPrXVIaNAou7eBSiMt4tIH6DkIzAJhYoVZ97dl9URe2qiU25UYEkuxkBHMrKM5Ozf9312d
 ntx9TdkOy6C+9WZW6w==
X-Received: by 2002:a05:6830:4c16:b0:7f4:eaa0:1d14 with SMTP id
 46e09a7af769-8309610ba27mr12321733a34.9.1791902262740; 
 Tue, 13 Oct 2026 07:37:42 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-83039a3e016sm12363996a34.17.2026.10.13.07.37.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 07:37:42 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: u-boot-amlogic@groups.io, u-boot@lists.u-boot-project.org
In-Reply-To: <eb8bab99-2d96-4089-b2ae-4492e763203d@linaro.org>
References: <eb8bab99-2d96-4089-b2ae-4492e763203d@linaro.org>
Subject: Re: [GIT PULL] Please pull u-boot-amlogic-next-20261012
Message-Id: <179190226198.4042530.4565446612423486493.b4-ty@konsulko.com>
Date: Tue, 13 Oct 2026 08:37:41 -0600
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

On Mon, 12 Oct 2026 17:44:21 +0200, Neil Armstrong wrote:

> Here's a set of Amlogic changes which enabled basic Amlogic S4 support for Khadas VIM1S,
> plus cleanup & update for Android support.
> 
> Thanks,
> Neil
> 
> The following changes since commit e1dcad5512b81009eaf7e472c20a8a15db8c4a0e:
> 
> [...]

Merged into u-boot/main, thanks!

-- 
Tom


