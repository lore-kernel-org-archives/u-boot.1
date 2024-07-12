Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 834C4C2BD09
	for <u-boot@archiver.kernel.org>; Fri, 12 Jul 2024 11:10:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CFA258871F;
	Fri, 12 Jul 2024 13:10:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="jVwtBbM7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7671788756; Fri, 12 Jul 2024 13:10:46 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 78C8488667
 for <u-boot@lists.denx.de>; Fri, 12 Jul 2024 13:10:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1720782618; x=1721387418; i=xypron.glpk@gmx.de;
 bh=sHB7V5SVBX/+QJPc/pjTyzu8tmeHXKKgvc6S1M5OyX8=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=jVwtBbM73LNw2NPDb8DgipTkXURT8DK7DIF78HHUxtb6oOsTNzhWFhayuZSU4Kne
 TrHXcbMf0JOEG1fk4nbeRPa+3vvn+EwsZcYEKMR6ylA+PVupw4wNSkJ9kyTVlhEL5
 YIBZp57QJ1PRTly7c9RUXc6xcwE5rbC1R6ZyvYRHRx2RxeRT05+eE0+ofO/5OTZEu
 1hEaCLvagg85qpJv3vMNtjgjrEMW8UCTJBQpzL0OJerJSeDO3/EIEWvA90iqW+K4A
 /+rXdcDxu+3iGE3FY9UTwCRQ+IfEt569vVBEmfHjpgd9EPT5Vf7UFtfCiIKVeENZ7
 /PClnf689QNa7vdV3g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.126] ([62.143.93.80]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MyKDU-1s9jwE1fkS-016vWj; Fri, 12
 Jul 2024 13:10:18 +0200
Message-ID: <96973f0e-a185-4758-8e8c-837206c6bdde@gmx.de>
Date: Fri, 12 Jul 2024 13:10:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] ext4: Fix integer overflow in ext4fs_read_symlink()
To: Richard Weinberger <richard@nod.at>
Cc: Jixiong.Hu@mediatek.com, sjg@chromium.org, patrick.delaunay@foss.st.com,
 ilias.apalodimas@linaro.org, seanga2@gmail.com, trini@konsulko.com,
 upstream+uboot@sigma-star.at, u-boot@lists.denx.de
References: <20240702194223.31998-1-richard@nod.at>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20240702194223.31998-1-richard@nod.at>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:tI3OflzTWLJSinGeLe2uiUa+ZprAg6Dota6zVqQ/Q5eBcsxu7w2
 rQAOMOa8WEqut5wKC97YyvBDh7f0ltLCwQaJSEwgEgWXI0mgFKv9PrGR1g3iPGtNMvJkYKg
 ZgnfK5IAFVj4gvhvro2vO2HsCgK0gBOGfbCed1KW3Bs4yvbN35vNjLhmITsel0B7Ik459PH
 QBYwdXtup4Sp4RDA4Gj+A==
UI-OutboundReport: notjunk:1;M01:P0:T/WxdI2LIQ4=;8XFs2C63GPl/HxcLGI5Lt7XZ4st
 yiNuJM28c0DfHGjN5HU8cC3D4k704mS/C+hFztuvx2U6gOBfft9EJ8J6CQDryahi1Qdac3JbL
 /20gd7SX96HtDqKe8leW94YKIQXbHicy7jqX2KhOkiMczOmJXVF6/DInvar7W2QXcpKz2K9PZ
 Ob0LL9O+EUk0BT+jFUhsF6Z9+yBxy43EGaWFFaN8LhJ3lu0Fx2kpI1Jkq0Nbaw92oANaFZOHL
 r/sPFG/vxixzeNM6prYYi5Gcm769m84Pj+mV92og5ohi8JyBFJr9kuqhJFiBqV4cONaOfTXVN
 lF42inXO7eb+uy0taJIxQF5H4kP7CATFc/0GMhzz0ozBl7cQhbkE+2W2VhxYAgRjIEdBLx3QH
 OM0qKNh2uCZn6hsSwl0yzyPiUZ+QlxuT1teAYCYloDDROVkcl591oppnlEBAGc/AfZnY818NT
 HHLTz2PbjuTi8grECQP+ttgkqoorDLgEZCFiFNUW8pplZxh7Zz1elr0epkoA8elu0wseUwVNt
 HsxyN9KrjftSkr6VujNeQwubLqYzkZ0PUfB+o6MpWFb2eZYqBps9CN+fthuWgODtEZTa2E1dM
 KUCqD2jTD2VcfMjaLQ0X7YREpBVkaiThv6/nHM5K6M7W5l05n7kfp8O3yQKWeKhi6KThyyfOz
 nYNamxbJoupb0o1RHde61XMqZX5VLTzVMnhSTqlRycQEUC/M3+Fjz+zQUtRdd+Mxic+0NlXBe
 Ig+QNvE51Sk+n5i67pRiqW9V8M88rHgSeETh74kD8bzPVv0i3/5A0+YcKhldF2eqyxSDzg/PJ
 QFLo8G4/CvTi3CNv25gaJVjQ==
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

On 02.07.24 21:42, Richard Weinberger wrote:
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
> index 2ff0dca249..32364b72fb 100644
> --- a/fs/ext4/ext4_common.c
> +++ b/fs/ext4/ext4_common.c
> @@ -2183,13 +2183,18 @@ static char *ext4fs_read_symlink(struct ext2fs_n=
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

U-Boot is freestanding code. You cannot use built-ins.

Best regards

Heinrich

> +		return NULL;
> +
> +	symlink =3D zalloc(alloc_size);
>   	if (!symlink)
>   		return NULL;
>

