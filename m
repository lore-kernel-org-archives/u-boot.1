Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 915CCCFA76F
	for <u-boot@archiver.kernel.org>; Fri,  4 Oct 2024 12:04:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0C90588B86;
	Fri,  4 Oct 2024 14:04:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="QxxUva7y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BA06E88B86; Fri,  4 Oct 2024 14:04:17 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6950188B63
 for <u-boot@lists.denx.de>; Fri,  4 Oct 2024 14:04:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1728043447; x=1728648247; i=xypron.glpk@gmx.de;
 bh=HPj9hjAOvUmrw0LfkIO17Ax/Usn+G7SfDrf/c7/FbO8=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=QxxUva7ytxLxG4SpbdnueIRoqbolO/frpoQ3KuddQOewZTHLgUNTI1EnVnMPEaj7
 vs0JRF5Ltt1InZO9aKR4hc4W11EVXi3BvhWLeu6Go8d8TLy+KYb26tOCllop9LEV+
 J8/njWisPVDZoRv9ExFGKJV4/5DR9sJAfjzS3d2e3WgvAo9bKToirHGNu+mdf19Bi
 vUKccyVcMKAe0qItjsrlpVVxEur9CTbGZ3Vf2BDJFIWQSHvvxnc24R/wFEJeVudzd
 dgoUlmaVUpPK3NrSdkZP0wOVKeXO1tl+1FotcQKrYgh8jYOFUJZXA0BBaO4srT6+c
 hfacphpsfyITaUUk4g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.103.101] ([46.114.111.239]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MsYv3-1s2eqK0JlT-00s4WE; Fri, 04
 Oct 2024 14:04:07 +0200
Message-ID: <5c4686da-f39f-4a48-ba57-4d2f7fb3e66a@gmx.de>
Date: Fri, 4 Oct 2024 14:04:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 03/29] linker_lists: set LINKER_LIST_ALIGN to 8 for
 CPU_MIPS64
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>, Raymond Mao <raymond.mao@linaro.org>,
 Maxim Uvarov <muvarov@gmail.com>, Tim Harvey <tharvey@gateworks.com>,
 Anton Antonov <Anton.Antonov@arm.com>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Dan Carpenter <dan.carpenter@linaro.org>,
 Alexander Gendin <agendin@matrox.com>, u-boot@lists.denx.de
References: <cover.1727968902.git.jerome.forissier@linaro.org>
 <1699de5384a71c0d0ad535cdc48cc2b95087719d.1727968902.git.jerome.forissier@linaro.org>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <1699de5384a71c0d0ad535cdc48cc2b95087719d.1727968902.git.jerome.forissier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:edV/TyGghoXfbe+0Dn46H83q6WgVrO0U1JnK5IlJQlQyZmPjylx
 4hzKqCcgH0iiaKcsNvrpaVrC40sPeArFEy0HgxQrJq305aKbbXh5ZTUfFnWFZc6V174DuWc
 eETn5fyoEGOZGAyrI6On+z/kyNFdNW7UauIIiC7PTpjXLCTkrCS0Tm8d6iUNSfJ70VFCZ4a
 Slo9iVHdwkia0u1O8060g==
UI-OutboundReport: notjunk:1;M01:P0:gxZBBfnAAF0=;smQYxptK+JwJxwFuvTYH04Mtqcs
 q5GsIz5erO+7WN2BTJzwizpGWyc/HLLbJO/Pwgh9Sn04YtMBefAu8z5iYPoIwwtnch9m+Hsp3
 hgE1xnFdA6osWAqEW3K5pVipG+v3bbrQALqU7FHeLyu22mCNF6boWZt68aWUYB38SOR86RdYF
 q3kqq5KBjzaAUWe/Lsr426dy/kluzaFotPN2fUEXKUJH7QbPWVuvj7ay9OZkoG3PqFkfd01HP
 KOJPTbdwTWLul/4GWdxoAdmLlVMTfbOpZNq1RdNiUJQKZaxsUCN9TjAt/eoyb9KLPIMnKwYhh
 PG5f0y6ENyFWcRzORByMGqSBNfYWkXpc+b1AYLXDEQ/oDKO5ZMVN+IT7zzkV+q+8SXKNXsjiX
 iy1bwKsuE1BAAhdDU47I8MDxTcwMccgJbH4ftPy8wTzsoWRPgrE3zZhvr9tIzPAs3U7Ce4o+Z
 0M3tkskF6P8Q/bDcfDSBoMNs7zvgCuE8WbbIlBO97XLq/7iMW0qZe6CZOvBuxVeBmzKYE9fSI
 N2slu5I68Cj/V9HVLbLW/afi8HYe2jtVZXefpggLwvNaeIqjkByoxFvQvMe3Gciy1AqZb0nRv
 DvZMeBWvinavzsfKWUD0sFWr20drRzFYGhmBNcqA/EeAElCO1thKDYyVy/Xp8eHCg3EmsEs7O
 8PBrE6WIjD1o075xTF+KGKk2QX8mT3q6gyHKMz+6H5UcC9m6mpALJil4h8qe7B1RPXjLuk8bj
 OmQy/4b/1vALiLJroSqvzNpMBm/tDwGIT92ky4vAzXhrkBJGiLYd1okADvMVrajSeGWiypLR+
 Rgt3Qu9FmG7XQ10rw5kjKZbA==
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

On 03.10.24 17:22, Jerome Forissier wrote:
> Note: Patch posted separately [0].
>
> [0] https://patchwork.ozlabs.org/project/uboot/patch/20241003142030.1610=
222-1-jerome.forissier@linaro.org/
>
> CPU_MIPS64 needs 8-byte alignment on the linker lists, otherwise an
> exception may occur. Fixes an issue found on malta64 with QEMU:
>
>   Breakpoint 1, lists_driver_lookup_name (name=3D0xffffffffbe043578 "roo=
t_driver") at /home/uboot/u-boot/drivers/core/lists.c:31
>   31                      if (!strcmp(name, entry->name))
>   [...]
>   ld      a1,0(s0)
>
>   (gdb) p/x &entry->name
>   0xffffffffbe04b0d4
>   (gdb) p/x $s0
>   0xffffffffbe04b0d4
>
>   $ grep __u_boot_list /tmp/malta64/u-boot.objdump
>   4 __u_boot_list 000018e0  ffffffffbe04a4d4  ffffffffbe04a4d4  0004a584=
  2**2
>
> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
> ---
>   arch/Kconfig | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/Kconfig b/arch/Kconfig
> index 8f1f4667012..8f4df849801 100644
> --- a/arch/Kconfig
> +++ b/arch/Kconfig
> @@ -45,7 +45,7 @@ config SYS_CACHELINE_SIZE
>   config LINKER_LIST_ALIGN
>   	int
>   	default 32 if SANDBOX
> -	default 8 if ARM64 || X86
> +	default 8 if ARM64 || X86 || CPU_MIPS64

Shouldn't we set 8 byte alignment on all 64bit architectures including
riscv64?

     default 8 if 64BIT

@Simon
I would not know why 32bit X86 should need 8 byte alignment.
I am a bit astonished that you chose 32 byte alignment for the Sandbox.
Is there any justification to use more than 4 on the 32bit Sandbox and
more than 8 on the 64bit Sandbox? If yes, we should document it via a
comment.

Best regards

Heinrich

>   	default 4
>   	help
>   	  Force the each linker list to be aligned to this boundary. This

