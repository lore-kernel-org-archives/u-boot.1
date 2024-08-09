Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1F31C3DA4A
	for <u-boot@archiver.kernel.org>; Fri,  9 Aug 2024 16:13:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 179648880E;
	Fri,  9 Aug 2024 18:13:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="tHw3jqjK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 813ED8895D; Fri,  9 Aug 2024 18:13:44 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8E5368870D
 for <u-boot@lists.denx.de>; Fri,  9 Aug 2024 18:13:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1723220014; x=1723824814; i=xypron.glpk@gmx.de;
 bh=Kj8mRrreSD7e5wT2tz4mHn1z1Pj8n5DNSnfw4L+UZ58=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=tHw3jqjKiLHhJBnbyXU/nNAoJamqAc7oM7dWayGiG1jJSVkWwAtmGzoQ/F1ujqfQ
 4IQ86QjpsrP7ZmfRQVhn6iWaAqfMkwa/U2hIWK4EphrnOKp9Ig4hTHlBjIDIfVprS
 /YLPjfE/qezzMbfgrBnZf9dwR2DqLwj0LStbJ+hWYzzxYr6gb+g3SelNVlG7LaY98
 DgqKEskhMyx9zlqjaqaLEttHIEMZsINNjDaHfUnS+U3YY/d8ahXNKWrFEqXa2Bt5T
 f4ZWt3/p+mp6wCj6rUY1lbJNMfk10jdAiNIjzV+3ZpQup5nSFg+nOj9PiV0C1v10X
 hxzv7waQpXz68V1KFg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.103.101] ([178.202.41.98]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MUXtS-1slDgc1r6W-00QejV; Fri, 09
 Aug 2024 18:13:34 +0200
Message-ID: <04ba0220-864c-40cf-bdc4-73ae6137b704@gmx.de>
Date: Fri, 9 Aug 2024 18:13:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] ext4: Fix integer overflow in ext4fs_read_symlink()
To: Richard Weinberger <richard@nod.at>
Cc: sjg@chromium.org, Jixiong.Hu@mediatek.com,
 marek.vasut+renesas@mailbox.org, patrick.delaunay@foss.st.com,
 ilias.apalodimas@linaro.org, seanga2@gmail.com, trini@konsulko.com,
 upstream+uboot@sigma-star.at, u-boot@lists.denx.de
References: <20240809095430.3656-1-richard@nod.at>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20240809095430.3656-1-richard@nod.at>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:E65PhAe7UA280KbmecA/5CRgxL2T16dmb31XvEBa9YzMTFmQ1tY
 VecExHdpPSHJhwqFBg4ezv8DMh/cGblRHa1fb6lMLUi2Rht1I7mPoNgQPztiyoLJB7Y0chM
 TkJsyqeUUmKjGhUAmgvwYhGvvtMHcplFCaKdMrmKCLIxJlApffNTYwx2wKeeVoNmUaWHTRs
 /mYztHQjy0w6EHBRgoMmA==
UI-OutboundReport: notjunk:1;M01:P0:sUmzo7BbcHA=;kYtub8KActI/XXzsO0QONb6Vxvx
 n4r3PZy/xd7AdqXWW92PYIwARXrGKM7gekdzaQImU+0+yjE0ZsFa5cJjQ9dGPLlcWN6IcKlFO
 zx21xMURmZoLJB31UBu8nnvLjSbhXkIk7bsWIlH7pGvfE+Hs+OIb4a1iZ4lMUcDY1atyWvccN
 itlZMlEcB2pupOELgX/mM0pdCYXqn/rKkxnCAHwOdvou5vJh6+NB5Hxmnrk5KnK24saLB+oQ0
 5e37z1YrhohJJr75vL1XReViPO/8OzLq7mUz9S5nFYKEQ7MwkD+93cVtHxFSBZRNu1wNfKYuF
 3HyIoOCZK15eA3sdFFgcIU+0JTp2/oTBHJaIeMeYgdRzfiZfeFISp7BmESUohFyXofSOCZO20
 b6nODWDuCcQvb6BpyN7ALyPMLSb8F0QCzaUW/H0jNJjVoTFbNB2MW/h4X4FhLAT3XCtVz780Y
 hxqjCucPS35KCTLrFINi8oQiDIMMqZCypDVRHa3WzyrzRt5zutWyf3OcMTDv766kPgJFBxzFK
 Y2qLZVhyE3iikbxE0/4uCEMB6UF/GlnsoxwM7bgYGa2Eez8jIed56mxp+ZKJCmVGxido4t/Hb
 GMfitpnXJamTNvOkFnOd+yQbyxOCa0axJfsLNPINlnIF1QfAnvr1S9Nezn5Ukxp1mPXzeThKG
 Nfl2N0jHqJ0f6D6ILKGDR/2ad90h6OEP4grZzrwTSm1OSBx8rAmnhek+gMjwZ/yeElNGAARHq
 gF0JB2/V2UvgEN/MV8oScLHY/r/nUJp6PARzzbaoMXX+9CL/HkybL5fL9ZbGEDk21TeDnfJyl
 f2H+ih/zT6Dwchb8TyzxSi8g==
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

On 09.08.24 11:54, Richard Weinberger wrote:
> While zalloc() takes a size_t type, adding 1 to the le32 variable
> will overflow.
> A carefully crafted ext4 filesystem can exhibit an inode size of 0xfffff=
fff
> and as consequence zalloc() will do a zero allocation.
>
> Later in the function the inode size is again used for copying data.
> So an attacker can overwrite memory.
>
> Avoid the overflow by using the __builtin_add_overflow() helper.
>
> Signed-off-by: Richard Weinberger <richard@nod.at>
> ---
>   fs/ext4/ext4_common.c | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/fs/ext4/ext4_common.c b/fs/ext4/ext4_common.c
> index 52152a2295..36999b608f 100644
> --- a/fs/ext4/ext4_common.c
> +++ b/fs/ext4/ext4_common.c
> @@ -2181,13 +2181,18 @@ static char *ext4fs_read_symlink(struct ext2fs_n=
ode *node)
>   	struct ext2fs_node *diro =3D node;
>   	int status;
>   	loff_t actread;
> +	size_t alloc_size;
>
>   	if (!diro->inode_read) {
>   		status =3D ext4fs_read_inode(diro->data, diro->ino, &diro->inode);
>   		if (status =3D=3D 0)
>   			return NULL;
>   	}
> -	symlink =3D zalloc(le32_to_cpu(diro->inode.size) + 1);
> +
> +	if (__builtin_add_overflow(le32_to_cpu(diro->inode.size), 1, &alloc_si=
ze))
> +		return NULL;

Thank you for pointing at the problematic code.

You are calling __builtin_add_overflow(int, int, size_t *).

__builtin_add_overflow() is not defined in the C-standard.

Is there any well defined behavior for this on systems where size_t has
more bits than int?

I could imagine implementations just copying an int to the first 32 bits
of alloc_size and leaving the other bits untouched.

Hopefully your C-compiler simply refuses to compile this code.

I would prefer to stick to standard C:

alloc_size =3D le32_to_cpu(diro->inode.size) + 1UL;
if (!alloc_size)
	return NULL;

Here an overflow can only occur on 32bit systems.

Best regards

Heinrich

> +
> +	symlink =3D zalloc(alloc_size);
>   	if (!symlink)
>   		return NULL;
>

