Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C7CCC369D7
	for <u-boot@archiver.kernel.org>; Fri, 25 Apr 2025 16:30:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A6888825A6;
	Fri, 25 Apr 2025 18:30:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nathaniel.land
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nathaniel.land header.i=@nathaniel.land header.b="caBOcf/B";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C7541826AD; Fri, 25 Apr 2025 17:40:22 +0200 (CEST)
Received: from goldencat.email (host212.sub-63-47-114.myvzw.com
 [63.47.114.212])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 14C4682115
 for <u-boot@lists.denx.de>; Fri, 25 Apr 2025 17:40:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=nathaniel.land
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=i@nathaniel.land
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nathaniel.land;
 s=dkim; t=1745595615;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fxbAIRTBFR2Fq7gD641bvHe8uq+PdDBiOAtRHmhobEI=;
 b=caBOcf/Bq78ytJKDEu/4ZbRb7jZTnJ6ZExEmwifKg+Upx86jXrH7rNSfESqKbNPlrI0c3V
 YGNJvtaPrihYiYEbkISnYSrU4+iy+60R8VFqtnZggKZpjrhQSQz8YmqDnEto7+UKYbXVnT
 gClQr9N8XqickLS7hKAYSeaJ/ct2UarA0pP2KtdJqVcLit8qSw++fzNis98yJmn88VjSA7
 ZnxuazzCgCsYX7NxoTgMvMJdWDpbTwpxHxHcXmjuyPFxnKmd9m/m1iZg9wktcyqxMvY1jC
 V5Nky1fvkYBZk4kMQblVdc1edR5ckFdmyO8lm4IkOFtpj/3YtRuyq7EG/vaLow==
Authentication-Results: goldencat.email;
 auth=pass smtp.mailfrom=i@nathaniel.land
Date: Fri, 25 Apr 2025 10:40:15 -0500
From: Nathaniel Hourt <i@nathaniel.land>
To: Benjamin Freeman <b.t.freeman16@gmail.com>
Cc: u-boot@lists.denx.de
Subject: Re: Flashing U-boot on a Google Nexus 7 2012 (grouper)
In-Reply-To: <6f4dda08-7944-45f5-b454-3880f8af4d29@gmail.com>
References: <6f4dda08-7944-45f5-b454-3880f8af4d29@gmail.com>
Message-ID: <61c0d2f160b74eaace0637d20f754821@nathaniel.land>
X-Sender: i@nathaniel.land
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: /
X-Mailman-Approved-At: Fri, 25 Apr 2025 18:30:36 +0200
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Hi, Benjamin

On 2025-04-25 02:38, Benjamin Freeman wrote:
> Hi,
> 
> I'm trying to flash U-boot on a Nexus 7. I've followed the instruction 
> from this page of the Read the Docs 
> <https://docs.u-boot.org/en/v2025.04/board/asus/grouper.html#u-boot-for-the-asus-google-nexus-7-2012> 
> but I'm stuck at the "Flashing with the NV3P protocol" part. I can't 
> figure out where should I get the android_bootloader.bin file mentioned 
> in the command: $ 
> ./run_bootloader.sh-sT30-t./bct/grouper.bct-bandroid_bootloader.bin
> 
> Does anyone have an idea?
> 
> Thank you in advance,
> 
> Benjamin Freeman

I haven't had a N7 in a long time, so I'm just guessing based on the 
docs here. It seems to me like you're just looking for a stock 
bootloader image to use there. If you have a copy handy, great, it'll 
probably work. Alternatively, I found some likely candidates here:
https://github.com/tofurky/tegra30_debrick/?tab=readme-ov-file#files

But again, I'm just guessing from afar. Good luck! =)

—
Nathaniel
