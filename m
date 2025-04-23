Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5163C369CB
	for <u-boot@archiver.kernel.org>; Wed, 23 Apr 2025 13:42:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 10DCF80FA8;
	Wed, 23 Apr 2025 15:42:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="bhkYsBBh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 228B780FDA; Wed, 23 Apr 2025 15:42:21 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BD2D180F9C
 for <u-boot@lists.denx.de>; Wed, 23 Apr 2025 15:42:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1745415737; x=1746020537; i=xypron.glpk@gmx.de;
 bh=MnP1uCp/apw16fmpa4L4XlwnNnThIurjRQYTWxZvMX8=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=bhkYsBBhwfMvl2Ak7SNVnhq3g+NPWMy0WL3GkXoeo/vQz9xZcPBwXi1WrIt6VYxF
 S6rM1exMGMwNnct8WsTZsiImpEOa+xTEyy/Ri8drT5auW7xqvrjF/58Wsfg6xrhL8
 MiAKkzXBiP+UNiZkOWb0Bogo8h8qSDCPQwn5bnXBzNthQ8VQG6r96rb9GET9bE9V5
 7LvaZpf3+EfUZC4bLiuT7OAU8w0hf0Llz5W11MNASu/W2g78vKWIFC8rHH3ggJh48
 ubLAyAjS5LsJD/W7lRCKRNs3EpMT281wBHDhc8vYEzJgLt1V/bUa52O1d0Xr6mBGK
 sAZFRrJgSU+xCAQOlQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.103.102] ([5.147.80.91]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MEUz4-1uJ6fr1dqE-00ESRw; Wed, 23
 Apr 2025 15:42:17 +0200
Message-ID: <b6e719bc-58dd-46b1-a4c5-79f2a8848358@gmx.de>
Date: Wed, 23 Apr 2025 15:42:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Dockerfile: Simplify applying cadence_gem commit to QEMU
To: Michal Simek <michal.simek@amd.com>
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de, git@xilinx.com
References: <5061af5aef7e964431679bee94b7ccfd2579e521.1745412278.git.michal.simek@amd.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <5061af5aef7e964431679bee94b7ccfd2579e521.1745412278.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:AARfSRFAAcA0HHXnEFGPciiKo/NgKxRvq8yb03uDJo/VMRS67MI
 TOHZ0iM8XKqGEWk84/+01eKJ7Vn4+Ac4kXcIadw8MGTm6APKt9X0xpZKw4oD5NypRUOxxWy
 stcVyV0wmZCV235+Fw3KtctQyp94Ate1nxegCachVlWbTvNBvIBlSAwqr15kE9/aP+ge5k7
 k34JKOKd5d2yxTXYTLWXA==
UI-OutboundReport: notjunk:1;M01:P0:Tua0l2epRvQ=;1dQxp+wyzH1okloTTlNS9KzJ6dl
 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
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

On 23.04.25 14:44, Michal Simek wrote:
> No reason to call format-patch and then apply it with git am. It is enou=
gh
> to cherry-pick it directly like it is done by commit 074bfab54d83 ("CI:
> Cherry-pick reset support for m68k for QEMU").
>=20
> Fixes: 50a907edbb2c ("docker: build QEMU v8.2.0")
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
>=20
>   tools/docker/Dockerfile | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
>=20
> diff --git a/tools/docker/Dockerfile b/tools/docker/Dockerfile
> index a0fd174ff602..0aa9d3ab3a84 100644
> --- a/tools/docker/Dockerfile
> +++ b/tools/docker/Dockerfile
> @@ -222,8 +222,7 @@ RUN git clone https://gitlab.com/qemu-project/qemu.g=
it /tmp/qemu && \
>   	# config user.name and user.email to make 'git am' happy
>   	git config user.name u-boot && \
>   	git config user.email u-boot@denx.de && \
> -	git format-patch 0c7ffc977195~..0c7ffc977195 && \
> -	git am 0001-hw-net-cadence_gem-Fix-MDIO_OP_xxx-values.patch && \
> +	git cherry-pick 0c7ffc977195 && \
>   	git cherry-pick d3c79c3974 && \
>   	./configure --prefix=3D/opt/qemu --target-list=3D"aarch64-softmmu,arm=
-softmmu,i386-softmmu,m68k-softmmu,mips-softmmu,mips64-softmmu,mips64el-so=
ftmmu,mipsel-softmmu,ppc-softmmu,riscv32-softmmu,riscv64-softmmu,sh4-softm=
mu,x86_64-softmmu,xtensa-softmmu" && \
>   	make -j$(nproc) all install && \

This change looks good but we should move to a newer QEMU version=20
instead, see

[PATCH 1/1] Dockerfile: use QEMU 9.2.3
https://lore.kernel.org/u-boot/20250418025743.529973-1-heinrich.schuchardt=
@canonical.com/

Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
