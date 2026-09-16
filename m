Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D1ABC88E5C
	for <u-boot@archiver.kernel.org>; Wed, 16 Sep 2026 05:13:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9F2C880969;
	Wed, 16 Sep 2026 05:13:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hTG7I1nJEEpk; Wed, 16 Sep 2026 05:12:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 9C6DB80874
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789535579;
	b=q3HTbOc8cs+AxYp5fW2uOySQI18aoPzxQiYPswrKsdjjt2sI+pZlQqxR3iVneyPFbl4D
	 YNsMSvLbmJzz9eN2ceK1Xs+9XOkvkLjtNgLKXCs8qdo3vdTZ2rB8iHoiV5lZ8jHHWaJxg
	 5uukE49wfBF1Uqyhr83KLNO5X6p2muKY7S6bEJfws7cySFuofpYvpDG32hcOwRWPZgEa8
	 cksc1OGKhtxTPATBlBlOXJx6KFyjEJ7QPpHSqjd03hlsRzug5DvUD7LY9PXzNp/QX0mym
	 PTLEtJ+b5b5fkxmypg/eywjMrWzY1YOmS0WfXrMuGBbWle1jBrlYVaw3Vcau5Qe9xJQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789535579;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Content-Language:To:Cc:References:From:Subject:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Last-TLS-Session-Version:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=5JQBvuokGl777aiKETyDKcjuwkW6vXgKB09Ku0ZNhk0=;
	b=cPt3I6CsmYGLX05/kZfHIwlo5sHCks9Xt8ZHG3Y2xNndHs6ljcxGJbpjecKgNuPDMUm5
	 QzzJFopnWKZOr6XbriVXNLkLfR+zpAGlPNqA6G5CQ8sb7fu2IyUoai8VZm1/5VWRUYm1X
	 s3XkSSlKmrTlroVwqTkdFbtA/9oCzfkPJEEimNyCYFW2TH4gx9VeCg62QiaTKl3uDyTkl
	 pGePbFJ7Q+TilJHAOdyIpe7BhhWdSJrU4PD5Tn/DJVfNRYYl1v0E3EEsAUmZys8AufxbO
	 6lt3KgNHPDEW64+ydstYfxUlkHfS77c1Jfzi3CFxeMBNf6EXdy6AkPznVPqY0UAmB+A==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789535579;
	bh=5JQBvuokGl777aiKETyDKcjuwkW6vXgKB09Ku0ZNhk0=;
	h=Date:To:Cc:References:From:Subject:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=EuSZVoV9E1FwCZmLs8kIFHrMkbwF6J/hJA+3rCXHocGQgmVijAbS6yaKJaVLDM+V7
	 3dY/O1pR+ngDnCS//RdUaYOQYbYDsBqddshUINd0uINLyB4+g3I9DRGQum1rr9/k28
	 En42p/oveK0VvHf/dSyM4ltXs9U1UzNTii7Wp5rpA5G7bMvFcL53OSdcaRAzoQffh0
	 Lzq8TFGVvtWj9MFjoY0/9Zid4KFp0Qg48pn+KXQaWvNdNKsifhvp59oYfGLWOjMnEM
	 70LOjmB1huj/Et3Yj6xmxAyhtqSXp9QRlu6vp48OhYA5I928cA4bHW5m3rkMmD4Y69
	 p8uPeMuae8YRQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9C6DB80874;
	Wed, 16 Sep 2026 05:12:59 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 0D41E422
 for <u-boot@lists.u-boot-project.org>; Wed, 16 Sep 2026 05:12:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id EDA4B607B7
 for <u-boot@lists.u-boot-project.org>; Wed, 16 Sep 2026 05:12:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RQJSY0En3Bzm for <u-boot@lists.u-boot-project.org>;
 Wed, 16 Sep 2026 05:12:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 7E95E60792
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=178.251.229.89
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789535575;
 b=nnckmHpokKSIzq9atqrTog2l5Dn1reALfznspmRO/XNTHYhGMHvDQS3Da/gLpT4YTrFS
 P4odPMDaGdbrfTeFQKPjLONNkcklVFxqISuaTs/3Sk8d5CyEu99E83yXTP1TekmZIA9LP
 7c6Az0+pR9VOoEI4pgvXHrUFh5C7SBMRFJ93r/cE0JtTN8wDT0zk/cJZ/WEM/ASg3kfNZ
 ajqLehUzHnNI7EvCpdpaGUSFtgwM5LvaF+Ls3lQsrcCC2gPoSq+uzfyLKUNBM+PRzfiRW
 nxg7PpM6nxIvOkU+I/X73MGZ1znY72qR5tUfQ4KlO8T/E98KR8NxTX1tux3KX3Am+bA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789535575;
 h=Received-SPF:Received:DKIM-Signature:Message-ID:Date:MIME-Version:
 User-Agent:Content-Language:To:Cc:References:From:Subject:In-Reply-To:
 Content-Type:Content-Transfer-Encoding:X-Last-TLS-Session-Version;
 bh=5JQBvuokGl777aiKETyDKcjuwkW6vXgKB09Ku0ZNhk0=;
 b=FNXRFx88eGr3TNoEzEzSkKbnSv0slR5tUFFb3CvjdMvkv5uSzp9DpX5pd8pqqvTqJESz
 AE5kzaI38OydN1oADnbx5PHM7zM41vND4Pz+itBUu/S3xQ5JTwFQjnUThW9Zw41/aV5DP
 WxS5H0XwfIRVzBeejlsSTaTn14uPUIJimMhuBPyjRD9iLFpDoEqpZX6gLJH61IL8KM2Go
 wzE5CLfKQH9NvH5N+NVOIdlZR44ztSZ4Rpnq6AY5hDR1GKoNu4tLj8G+6ZaKA2Vyy0J2I
 pbKspliynkrfUFh46+KTefJmQVgv3O6sA9J5Tkuri73fjUx/bUGbSPFSmRkhtjTikRQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=nabladev.com; 
 dkim=pass header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256
 header.s=dkim header.b=cR4oyiwu; 
 arc=none smtp.remote-ip=178.251.229.89
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=178.251.229.89;
 helo=mx.nabladev.com; envelope-from=hs@nabladev.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256
 header.s=dkim header.b=cR4oyiwu
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7E95E60792
 for <u-boot@lists.u-boot-project.org>; Wed, 16 Sep 2026 05:12:53 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 460B4101C8F; Wed, 16 Sep 2026 07:12:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1789535571;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=5JQBvuokGl777aiKETyDKcjuwkW6vXgKB09Ku0ZNhk0=;
 b=cR4oyiwuFtibr534lGpN8BouX/jgIK1UhkwmYK1itLN+Fje79r5FasNznQ+Upts16A9RXY
 wt4myNakyhNCyjttkr0PnDR0bpXLq4BCA2qiczmKJoofR6sX6XbdB7GXsYO3B6//B8VuJc
 VczHAUNeRWkFQFVFpkKkRYSrgRACjHUeJpVNkaJ2PLsHthqGhaT59PvKUpVLvjJiwyf9OE
 8DKHzSrm7GCo2O6LfEcH0Ff9/XKXwkojuGHLBKrK/24daKlgKg0a6k40ANGJFcMyv1Hmb7
 WyR+OduPu36q/eZrbTqf960fKVhh+7R6ktO4exvN9oF+cyRiaMuc3100SYq0EA==
Message-ID: <62fae71d-c232-2b62-04a3-0d4907ab0a68@nabladev.com>
Date: Wed, 16 Sep 2026 07:12:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Content-Language: en-US
To: Mike Looijmans <mike.looijmans@topic.nl>, u-boot@lists.u-boot-project.org
Cc: Daniel Golle <daniel@makrotopia.org>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Kory Maincent <kory.maincent@bootlin.com>,
 Kuan-Wei Chiu <visitorckw@gmail.com>,
 Markus Niebel <Markus.Niebel@ew.tq-group.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Peng Fan <peng.fan@nxp.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Philip Molloy <philip.molloy@analog.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Raymond Mao <raymond.mao@riscstar.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
References: <1b153bce-a66a-45ee-a5c6-963ea6fb1c82.949ef384-8293-46b8-903f-40a477c056ae.4c5643b3-0c93-4843-8d61-6d64d131693b@emailsignatures365.codetwo.com>
 <20260916050312.7618-1-mike.looijmans@topic.nl>
From: Heiko Schocher <hs@nabladev.com>
Subject: Re: [PATCH] MAINTAINERS: Change u-boot@lists.denx.de to
 u-boot@lists.u-boot-project.org
In-Reply-To: <20260916050312.7618-1-mike.looijmans@topic.nl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

Hello Mike,

On 16.09.26 07:02, Mike Looijmans wrote:
> The obsolete 'u-boot@lists.denx.de' address occurs in several places. Use
>    sed s/u-boot@lists.denx.de/u-boot@lists.u-boot-project.org/g
> so that patman and similar tools, as well as mortals, send their e-mails
> to the correct mail list address.
> 
> Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
> ---
> 
>   MAINTAINERS                     | 2 +-
>   README                          | 6 +++---
>   doc/develop/security.rst        | 2 +-
>   doc/develop/sending_patches.rst | 6 +++---
>   doc/git-mailrc                  | 2 +-
>   tools/patman/settings.py        | 2 +-
>   tools/u_boot_pylib/gitutil.py   | 2 +-
>   7 files changed, 11 insertions(+), 11 deletions(-)

Thanks!

But your patch is based ece349ade2973e220f524ce59e59711cc919263f

A grep on current main HEAD:

*   2c7eaee7b34 - (HEAD -> main, origin/main) Merge tag 'net-20260915' of 
https://git.u-boot-project.org/u-boot/custodians/u-boot-net

shows me:

u-boot [main] $ grep -lr lists.denx.de .
./lib/fdtdec.c
./.git/objects/pack/pack-64b7ed596b959a25ed4b70ca3cb0bcf929d72ada.pack
./.mailmap
./doc/README.cfi

Which seems fine to me...

bye,
Heiko
-- 
Nabla Software Engineering
HRB 40522 Augsburg
Phone: +49 821 45592596
E-Mail: office@nabladev.com
Geschäftsführer : Stefano Babic
