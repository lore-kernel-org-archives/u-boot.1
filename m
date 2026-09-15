Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DB8AC88E7D
	for <u-boot@archiver.kernel.org>; Tue, 15 Sep 2026 20:35:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E1C9F406FB;
	Tue, 15 Sep 2026 20:35:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qPe35W2Gpuah; Tue, 15 Sep 2026 20:35:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 4C859406F2
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789504536;
	b=PH+bOqwkMzbg2vYHwqM2gn5Elau1srvTbdxsnskhMlDvPlWDNXajQ6XBZSHKax+nk7Lu
	 VgLQ3ixH5zTVwWOpk0T88h2jpXZbXSCMIGDUNzWM8TOL4x7Pp865v1zB6YMmbY+vGI9pL
	 eAzr5bKB01YL7GFQ2+3x4OAcxDruV4FDEo9vAq4pQog6imCauYI9cfULkJis2NT0KLW+g
	 i/CPMcda4MKlxu3dGbssTgu8i4fwtjK3IKxDVqWFTEqxVOiDEGf1KGfMTMRMMnw+pqrTL
	 L7kZGFbwGGMwKgDCv5D/LA7uHIWAFgiee4Z6t++WZSjKUXWwCThOAJ2H0WvN/SbTOqg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789504536;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=0zsnkwcnJsw3IcFUbMuGtvfkuAQ1LFNaznRkYjvVQy8=;
	b=BSv5HKTlIMUypYBKr6aukWfMWdPu8ArO3RFaMnV2vdxYeb19JTWoAMAaM8itu2XqEiUt
	 2qb1F2vleg0sYl+2HvVGSRD3aK2ERCZnV5qZWny6p5ZBpbbt7TDqXkIZM2A6WwNgySxHr
	 ZE6lW1ZacWTEsx1+I1e3eKLc9AUE+nvccdDew1kTVcZwQdRnN9mSKz3TNyGP1UoO/h/fi
	 6ou96yKdy6DwIBHbTO2nTPTGEmB0mrdD9LNd0HohIyNcqfhL0j9hCW2752ttkSvR3OiY0
	 ZT82TFBdDfts6WTjZBmkMJryueVMIG6iuAfmo36MdzfkwNLe1RmARDEQPS9xXMNsS9w==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789504536;
	bh=0zsnkwcnJsw3IcFUbMuGtvfkuAQ1LFNaznRkYjvVQy8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=0t3KOtPY82YAR4xD7/WJYg/EBAxIiwKx5/8mz6dknpiNiU5/QPEuM6JG19tXwIV6j
	 lO9nuh5dthUWqtIBR2Sy5ZWrW2N8tLjTilyMRhid9fknMMTT4dLZkEYQUIhsZRJLbK
	 WEX43+WIfznRXrU/Hlnjm5aAvH9Da1PD+cynr+U9c01Wuvk9mSTRmGxaFGJFSrjWqp
	 5DX1NLrk49AgysZvoMYZ6HHBeG7rlosQeswfIRyX6DW/Acrq1LyXrKdL0mpPSz4M2e
	 JdhxQRVC4kv7LQa/HgLAIffDD4gwXMh7rdHooVWD9MmlIJVMqshUUKTODSv5ztEmBT
	 D9W0ViIDk/PcA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4C859406F2;
	Tue, 15 Sep 2026 20:35:36 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 3ABBBEB
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 20:35:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 384EE6061B
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 20:35:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id elBODKuE8eLN for <u-boot@lists.u-boot-project.org>;
 Tue, 15 Sep 2026 20:35:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 8EEFF6060D
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:32::11"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789504526;
 b=HZ18iMaLHKkenMhIQCsgmxyCVo0HgimY2IyIEVTrWmLkGXP0wCrQ/608vTcNES1ZZMjG
 SO677oT5CV2Gfj88g2nhgt10n4WzEhe4N4y5IsosTgTjrzL6ptfizosS/+tgImUFh0aio
 2u7I4373LbCY0Lp4s375iXH5hVAzCwzXE9hmj57zE2x2e4q+MJucJR9UrjUBXrFKOlHMB
 cHYNy2Z89tEVxBJXM8W8wpb8ANpeyiowhzoMbi0A/eoFzKPxjFekp9CFv75nME+3Cc/iy
 bYmO2WMdMVAzr1WwFFpBEhIOYKRjR/U79jaJz4d81q9YqJA10ED5Pob+zFtJaY0D9VA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789504526;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:In-Reply-To:
 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
 Content-Transfer-Encoding:X-Mailer;
 bh=0zsnkwcnJsw3IcFUbMuGtvfkuAQ1LFNaznRkYjvVQy8=;
 b=jzWJ7qrdaDK4VbwD56FpSWiXELZeaGRk3vyKJHmRGryKI+cGemmgDog1V/lKn4xRzwE6
 p7/gdF7E6EjE/MaOVD9kR9s5WK2OXR9v4T35k0WlrsZyYwFTTPSzjnbomm3JLCUwZEVVs
 VGWsvIgmGi6hNjOKuhw4PdgKMLXtmWTc8Gqot95nKjZV2VTUD76CavrrlUvibzug3+C7i
 SxnGKJyK5009rlZTW29sIjdXTwTE/1wWuaSQH0MpOuztJm3daftXqcfuLKGEzGn34TsqW
 En7H+aCZ233ydylW3rpIdTVK1k5HkjJivyHgmLM76WCMOe+6roqXJvK9SrI8M+HUFLQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=konsulko.com; 
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=d8KNqrra; 
 arc=none smtp.remote-ip="2607:f8b0:4864:32::11"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:32::11; helo=mail-oi2-x11.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com
 header.a=rsa-sha256 header.s=google header.b=d8KNqrra
Received: from mail-oi2-x11.google.com (mail-oi2-x11.google.com
 [IPv6:2607:f8b0:4864:32::11])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 8EEFF6060D
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 20:35:26 +0000 (UTC)
Received: by mail-oi2-x11.google.com with SMTP id
 5614622812f47-4b37a3ed714so223395b6e.0
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 13:35:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1789504525; x=1790109325;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=0zsnkwcnJsw3IcFUbMuGtvfkuAQ1LFNaznRkYjvVQy8=;
 b=d8KNqrraIThCLaxojKk8Z3eIQjkAWK28ewFOeTZrsF/x2AZ0001XGAfckWvSxsK31n
 bMcWMIsvS4Ai9uP8cBuROIbwDjYJZLpAGX32g9bJhF1WyPTeSkTwSqR604knrVE7/i0G
 aAhH+0iMk9Z+XT0v9HEStu5m7WpGnB9SZT2tc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789504525; x=1790109325;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=0zsnkwcnJsw3IcFUbMuGtvfkuAQ1LFNaznRkYjvVQy8=;
 b=qalmQ9/4UtBY7ot7rjb4wOQBTFOLeGMoJNEdyOw/OiVFQt8Jwgu4xuRhnkfb1kj839
 Ny27XJqRSH8GnGwbVjsaq8qkTzWYmALA7JJO8c8ZiDQ9geOknimOFe1++/twGc6hG54p
 cYFvZppt5+PlOnxEskHRfKrfcBB3zrVjMvHfw2iD033AnnO5Dc83IeS0uBwE76Dfg8Ui
 wW1pwVDql02LJcZ42xq+H5lALz2BV1kq/4v30fvUP6npfEHjKKLlQXoUaMoS3xLnEkO9
 KqpM+BtqcCSn4Led9+v3gpzRj+MqNYhF6tV3fi3Ggl7KAVp0RDP5M+LVRThChR1DfsI4
 pMmQ==
X-Gm-Message-State: AFuF++miRitDJRpidxzDmYxZaXJoHqlX1FHDFMKNkrMHFusLXPFJVZTY
 oE7Rk6LYXGTllHPKcohYbKimqwndJhGPw8uWD+QuBzDQVKFKNy18F/cgVf0kyrfr+LnovSAWOqM
 NR2VnKVC4hbYs
X-Gm-Gg: AYBFou2VqB6kY2frWqstStG9itahGGtqTC51CnCD1Wr0USH04Dio1ZA/BztX+9gWiPk
 4RZ3dX9scAJ7H21CgCpZtABYwttdaYoZAt/iXLCnoGvrS7gYL92bDYf+xB7qIZRPeR5vHaKUDfV
 Zn4SYEfgZqgvkvjk5FZRXHQQJGZFJNGZEDXt8GI1RGKakZc1Itix+noJescp4Sbhy30Q2Qi646q
 79nSqsNF+GlJN5okZUX9DX/1pMR3jkg4JzhB2Iftss9ZkwwCsmt3hDN929iReUBOaz6pfbWrUgW
 Qb5cGcFK+WCAbz7ubqPaMklku+dVscdUCQwlkUikd2qpNSG1XNYDWNrrR133HAFPIYG9Am2SWkx
 Icd5gp9N+osgG/K17jZioiC9KzF4FBQpEzBQPUihr/cp1wNa8PV0jmlocR+6avVWphbopPzRB+5
 JglwfjdcHHA79mzINMQS403nNzlA9zUZ8m9Y35h6n0OI5vmeGp9DuWF+UIF3BLtVPixEnRyXJjo
 bWTgPNC5FYwa3l79R7EUEbL8idzMVdIEwpyqvXaLgkUVOtWb+9ZifyaBTNTwFO2kd022kbNk/7a
 cNtZB0bWklGZWKFniyo=
X-Received: by 2002:a05:6808:4f0f:b0:4a4:ed9a:e7ac with SMTP id
 5614622812f47-4ca499ce7f8mr74272b6e.1.1789504525307; 
 Tue, 15 Sep 2026 13:35:25 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4ca20e54317sm486511b6e.2.2026.09.15.13.35.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2026 13:35:24 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: sjg@chromium.org, Naveen Kumar Chaudhary <naveen.osdev@gmail.com>
Cc: u-boot@lists.u-boot-project.org
In-Reply-To: <7guo2gscv64pjcfcp7wjvs2r6msrxgylgtpcurbcfpd73siplj@zc363ld34pb5>
References: <7guo2gscv64pjcfcp7wjvs2r6msrxgylgtpcurbcfpd73siplj@zc363ld34pb5>
Subject: Re: [PATCH] bootstage: fix record name fix-up offset in
 bootstage_unstash()
Message-Id: <178950452442.931545.11322644414007942267.b4-ty@konsulko.com>
Date: Tue, 15 Sep 2026 14:35:24 -0600
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

On Tue, 01 Sep 2026 15:51:23 +0530, Naveen Kumar Chaudhary wrote:

> The records read from the stash are copied to data->record +
> data->rec_count, but the loop that assigns their name pointers iterated
> starting at data->record + data->next_id. These offsets only coincide
> when both are zero; with a non-zero next_id (e.g. after a 'first' init,
> where next_id is BOOTSTAGE_ID_USER) the names are written into the wrong
> records or past the end of the array.
> 
> [...]

Applied to u-boot/next, thanks!

[1/1] bootstage: fix record name fix-up offset in bootstage_unstash()
      commit: 1fa8b586404a816bb220d87f52c062d9e8ba4915
-- 
Tom


