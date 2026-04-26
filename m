Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D597FF885C
	for <u-boot@archiver.kernel.org>; Sun, 26 Apr 2026 12:57:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 50509839D9;
	Sun, 26 Apr 2026 14:57:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=saramena.us
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id CD35284099; Sun, 26 Apr 2026 05:51:43 +0200 (CEST)
Received: from saramena.us (murtaza.xen.prgmr.com
 [IPv6:2605:2700:0:2::4713:904a])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AB37184011
 for <u-boot@lists.denx.de>; Sun, 26 Apr 2026 05:51:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=saramena.us
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=murtaza@saramena.us
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com
 [209.85.215.174])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by saramena.us (Postfix) with ESMTPSA id 9B27915AB5B
 for <u-boot@lists.denx.de>; Sun, 26 Apr 2026 03:51:39 +0000 (UTC)
Received: by mail-pg1-f174.google.com with SMTP id
 41be03b00d2f7-c6e2355739dso3614001a12.2
 for <u-boot@lists.denx.de>; Sat, 25 Apr 2026 20:51:39 -0700 (PDT)
X-Gm-Message-State: AOJu0YyvP1py4f0uHqelFZ/AgEaXCNPxuNcFgigi3fOec3LfGww/rjwL
 3BHzP4qgn+sHThkRhTGYviH0R3A49ZSY8v+530hmnK7j4ZMHS2P3anRvq3OxOC2c8Plf/AIZWOx
 8SP43N4IJUOdiPnTVuUHgflSc/ptznz4=
X-Received: by 2002:a05:6a21:3383:b0:39c:cdb:5d78 with SMTP id
 adf61e73a8af0-3a08d8a9e98mr42340835637.36.1777175498996; Sat, 25 Apr 2026
 20:51:38 -0700 (PDT)
MIME-Version: 1.0
References: <20260407213231.19133-1-murtaza@saramena.us>
In-Reply-To: <20260407213231.19133-1-murtaza@saramena.us>
From: Murtaza <murtaza@saramena.us>
Date: Sat, 25 Apr 2026 20:51:27 -0700
X-Gmail-Original-Message-ID: <CAOqbjtvN_s1xjXgr1eGKq=VVtJAamSTiC=1aw5O_xTfaKEw8RA@mail.gmail.com>
X-Gm-Features: AQROBzDLq_xybu4xfZz9vFTqFM-fDtCuItVdBHpQPoUhbnIF7MQOcrNvMM7fapY
Message-ID: <CAOqbjtvN_s1xjXgr1eGKq=VVtJAamSTiC=1aw5O_xTfaKEw8RA@mail.gmail.com>
Subject: Re: [PATCH] net: nfs: fix buffer overflow in nfs_readlink_reply()
To: Murtaza Munaim <murtaza@saramena.us>
Cc: u-boot@lists.denx.de, trini@konsulko.com, jerome.forissier@arm.com, 
 andrew.goodbody@linaro.org
X-Mailman-Approved-At: Sun, 26 Apr 2026 14:57:25 +0200
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hi

Any updates here?

Thanks!

On Tue, Apr 7, 2026 at 2:32=E2=80=AFPM Murtaza Munaim <murtaza@saramena.us>=
 wrote:

> nfs_readlink_reply() copies the symlink target from an NFS READLINK
> response into the global nfs_path_buff[2048] using a length (rlen)
> obtained from the RPC reply. The existing bounds check validates that
> rlen fits within the RPC packet, but does not check that the result
> fits in the destination buffer.
>
> When processing relative symlinks, the target is appended to the
> existing path. By chaining two symlink resolutions, a malicious NFS
> server can cause the combined path to exceed 2048 bytes, overflowing
> nfs_path_buff and corrupting adjacent global variables (nfs_path,
> nfs_filename, nfs_download_state, file handles). This can be
> exploited to achieve remote code execution during NFS boot.
>
> Add bounds checks against sizeof(nfs_path_buff) before both the
> relative (append) and absolute (replace) memcpy operations.
>
> Signed-off-by: Murtaza Munaim <murtaza@saramena.us>
> ---
>  net/nfs-common.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
>
> diff --git a/net/nfs-common.c b/net/nfs-common.c
> index 4fbde67a760..30f549f9e1b 100644
> --- a/net/nfs-common.c
> +++ b/net/nfs-common.c
> @@ -671,14 +671,24 @@ static int nfs_readlink_reply(uchar *pkt, unsigned
> int len)
>
>         if (*((char *)&rpc_pkt.u.reply.data[2 + nfsv3_data_offset]) !=3D
> '/') {
>                 int pathlen;
> +               int new_len;
>
>                 strcat(nfs_path, "/");
>                 pathlen =3D strlen(nfs_path);
> +               new_len =3D pathlen + rlen;
> +               if (new_len >=3D sizeof(nfs_path_buff)) {
> +                       printf("NFS: symlink too long (%d bytes)\n",
> new_len);
> +                       return -NFS_RPC_ERR;
> +               }
>                 memcpy(nfs_path + pathlen,
>                        (uchar *)&rpc_pkt.u.reply.data[2 +
> nfsv3_data_offset],
>                        rlen);
> -               nfs_path[pathlen + rlen] =3D 0;
> +               nfs_path[new_len] =3D 0;
>         } else {
> +               if (rlen >=3D sizeof(nfs_path_buff)) {
> +                       printf("NFS: symlink too long (%d bytes)\n", rlen=
);
> +                       return -NFS_RPC_ERR;
> +               }
>                 memcpy(nfs_path,
>                        (uchar *)&rpc_pkt.u.reply.data[2 +
> nfsv3_data_offset],
>                        rlen);
> --
> 2.50.1 (Apple Git-155)
>
>
