Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B556360A3826
	for <u-boot@archiver.kernel.org>; Fri, 13 Nov 2026 15:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=l3V8EKf+;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XY5YKi5A
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8C1DF6061C;
	Fri, 13 Nov 2026 15:56:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vt8DvE9_AZ7R; Fri, 13 Nov 2026 15:56:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org E0D456061E
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794585409;
	b=FmS/gE+J/6pFQqZxo9/j+cDnEW+b+ISXN1SCDvcO6hX+j1F9FirIlVtgLq7zVqdKvyv3
	 l5r/BLsjcINV89oeSw3NCnDBISyUkQ3DmLRKimBB7w0aJG2IgLgSA8mzft/n5yIhMeDV7
	 +3oeFqGv2FcOCOekvXQ2gQ8oyXsT/gpXK+g5623inzHAi0A/bmuY/1/g4bRHHSWVOWZRz
	 m/c4JSxW3D6cfalH/fP0E+7GmTBG8vStAISmaO5c/odJtfTZqMHX2XrGLlRv/ggBV5yta
	 WwoWv1b7pFs/Eegn9MdEjJWQFiLGms8mlP8sYdMveCZi9kp59bReWQjSBRwMru/yaog==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794585409;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:References:
	 Date:Message-Id:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=Y1SQwfvYKHu3WxmOW9pZp22ZV5mIXTVPAYH3t0DbnXY=;
	b=SMrT7hhJZrqe6aWSj7Bd/u/Zdb0K2Uogb7tVCsXjogbGe3DRSwYQyDffRBoUrMp1H6tx
	 IBy/zBcMI4UfoDfnB9gzyNBX8Ije7OU3S+fhGrW6BcQL9i5MevY0nZemAnEIcquQNk0yu
	 kC/P2qyhs32qnx0T2aFD8dUs/CFMf21vFVkoTNAfuq+YoEdfXr7T9tqad01PwsTszQrnW
	 EKqbM1Jy4XJTDMYWEQlGbhCmi0Za1jL6wq14km9M/7GDPrlsD7Vupq+NuhyKq+R5Kz0qS
	 UNChZX+bLjht5m44EEX/EgIlgO+bg6S6cU8ujHWDs9foUtEeS5y29pdX7c5R0QvL5cg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794585409;
	bh=Y1SQwfvYKHu3WxmOW9pZp22ZV5mIXTVPAYH3t0DbnXY=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=l3V8EKf+9STUtFaoAiQahFrzynl/Ts39e8z4nP35Bxxb2I36BVaRmfh3y71E+YsVe
	 VFeL7sMGQXGTIEBNueXyEeqOd0bKkSjD8FkgNgRBld7370ScuiKOCBqb3IOGZ3mI4t
	 SOIp6R0lch/L72hzRLh1/4Vlh9HQ7mY6m9a3d74SBlPP3VGqOhJg+TAHYkKowL3Itp
	 dYDmjs7l5rI4hkGIa1ins4GwMkRSIeAwo7zk88LAbu4huq4Kj8QbFwgIIyAan077rf
	 tUHW1YbrXuF+RIkAKK4rmnwRm7aUiHpqhEwhnv29wVH0WbngNwS0p9t2kg6yWZk1qf
	 tdky2kfVcmDYQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id E0D456061E;
	Fri, 13 Nov 2026 15:56:48 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id F1854F46
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 15:56:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D78E840987
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 15:56:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1kuXkjBltNsB for <u-boot@lists.u-boot-project.org>;
 Fri, 13 Nov 2026 15:56:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org D855840979
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=172.105.4.254
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org; envelope-from=mkorpershoek@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=XY5YKi5A
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D855840979
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 15:56:45 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 2BA6262810;
 Fri, 13 Nov 2026 15:56:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 803291F000C4;
 Fri, 13 Nov 2026 15:56:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794585403;
 bh=Y1SQwfvYKHu3WxmOW9pZp22ZV5mIXTVPAYH3t0DbnXY=;
 h=Subject:From:To:Cc:In-Reply-To:References:Date;
 b=XY5YKi5Adtme427L1R+RIuq658J0tOsW5U4svriZkHyJvmeqeCg8GDRB7Ix+D6mn6
 fSyhgdD0BdQ6j0sAcSljv/WpLi7kErftrjHha+QVhCtslRyYawbIAcxa5T+whUxRvm
 Ew1BGO4ZbCUwlY9aEGNFc3EYtf1HQud8IvvN8OV28vb/AL+yd7kTKlu5Dr+d4c1WJ7
 o3Bdc5fM6bLHcKk8HwZmJfewygXiedUWoeEK02iZnWE1arONnUGEP+ilDif+DywXjA
 MGHKj/KFWRLRJ87FAzWovLLs2FAzJOGp1idk16bUfN6meHLFcoRJN7zaqpRAsvvH3n
 hWnr0jMguKAVg==
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] usb: gadget: f_mass_storage: add SuperSpeed
 descriptors
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Alexey Charkov <alchark@flipper.net>
Cc: u-boot@lists.u-boot-project.org, Lukasz Majewski <lukma@nabladev.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Marek Vasut <marek.vasut+usb@mailbox.org>, Tom Rini <trini@konsulko.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>
In-Reply-To: <20261106-ums-ss-v1-1-ad215bcdb735@flipper.net>
References: <20261106-ums-ss-v1-1-ad215bcdb735@flipper.net>
Date: Fri, 13 Nov 2026 16:56:34 +0100
Message-Id: <179458539432.70612.7440620049911418898.b4-review@b4>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1539;
 i=mkorpershoek@kernel.org; h=from:subject:message-id;
 bh=OmiwyHbDLbdtbXQOemgMTCyipKdvJqEFhBPTiCFrciw=;
 b=owEBbQGS/pANAwAKARkNHbRmThk1AcsmYgBq9zM0h80pY4naTmI2+v6zvh6zOmc7r+jIdxlYp
 /wxLiiYnKqJATMEAAEKAB0WIQQu6UKnth9qvlMTrQAZDR20Zk4ZNQUCavczNAAKCRAZDR20Zk4Z
 Nc3EB/9ekH+5r0G/Q63u3qVf9gUPY/rUoA1y3m7WkJ9pbhphsNOb4rImR8BEnGyqLQ0CmbZ3tsp
 nMuj9+IeSRocEj+EC3g/296pBsPb7cLTTIP2+h+LOVyTaVvFMVS/y4FcFRHCi7DpBi4/6D8wrG8
 tRm269P7BosLPI1J56vIn6rCq6P7fLWlQ3wSxT3IF6uT/EW/SRD4S8OTFJvk6r0IYRW+8j0SMAg
 2GsKz9Ddnzt8kHmKz9huGOOIufmmNm6jP7JxmcB4po3RJS96eCz65xR52elEXfJMRABtR8fpmFE
 8GWy1CccCOytHnrvJOPIQSiK+Lveib89i47vRfPIEFoGzmKm
X-Developer-Key: i=mkorpershoek@kernel.org; a=openpgp;
 fpr=8234A35B45C0D26B31C1A2DA570338B018144F28
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Alexey,

Thank you for the patch

> The mass storage function only provides full and high speed
> descriptors, so a SuperSpeed-capable UDC that comes up at SuperSpeed
> reports a device descriptor with no configurations: count_configs()
> skips every configuration without SuperSpeed support. The host then
> gives up with "no configurations" and keeps power-cycling the port,
> which makes `ums` unusable on such controllers unless their DT caps
> maximum-speed at high-speed.
> 
> Backport the SuperSpeed descriptors from the Linux mass storage
> function, adapted to the U-Boot copy, so that `ums` enumerates and
> runs at SuperSpeed. Leave out the BOS and device capability
> descriptors that came with it, as nothing references them.
> 
> U-Boot has no config_ep_by_speed(), so set the bulk endpoints'
> companion descriptor and maxburst by hand before enabling them.
> Otherwise the UDC sees a maxburst of 0, which DWC3 turns into an
> underflowed burst size instead of the bMaxBurst the host was given.
> 
> Based on Linux commit 4bb99b7c82ba ("usb: gadget: storage: add
> superspeed support").
> 
> Signed-off-by: Alexey Charkov <alchark@flipper.net>

Thinh from Synopsys submitted a similar change already which got merged
with commit 33194a8025f9 ("usb: gadget: mass_storage: add SuperSpeed descriptor support")

Can you please let me know if that works for you?

If not, please submit a new version to fix that commit.

Thanks
Mattijs

-- 
Mattijs Korpershoek <mkorpershoek@kernel.org>
