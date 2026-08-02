Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B81DC55162
	for <u-boot@archiver.kernel.org>; Sun,  2 Aug 2026 06:03:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id BFFCB60672;
	Sun,  2 Aug 2026 06:03:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5lrBgGIHH9WE; Sun,  2 Aug 2026 06:03:19 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org EFD196064B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785650599;
	bh=IbyTOOxQ+HRtvxnxSNpVTg5qymQ/avPY5grfP3j4rJI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=UDnHCgJonvRAncsD8sSYInIbJAUwoprDIKBnPUzX0OMWRWuMvDyuSEjJEJc1LSZkk
	 hg6s+CjR/fzthtfbJ3SRUFyGX9xWHWybfI5O3Gg+C3RNSLIfY0hSGBFF4XeH+A5y2i
	 rVwv57c15lYL262lpZ7dX+YLOccZgIQOmKeQa+6Tn2Ue4f0gQ1RhwtId1DQ1rSXdsO
	 gCq6K1tPpSKWyr/8s1cmIKBFS/9rIyuZDsOGix1ImsLd26HEM1srdyhqTPZEnVKY9p
	 m08QloTLy5Ge1ZoSPCINeqHBwwPP8epnMe+zBaeORmCJGEEwOkOEAZxZZUDVfYnZmk
	 lUl71ejOxbQnw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id EFD196064B;
	Sun,  2 Aug 2026 06:03:18 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id C2815FE3
 for <u-boot@lists.u-boot-project.org>; Sun,  2 Aug 2026 06:03:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A83DA6064B
 for <u-boot@lists.u-boot-project.org>; Sun,  2 Aug 2026 06:03:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3Hv7rxsqx92p for <u-boot@lists.u-boot-project.org>;
 Sun,  2 Aug 2026 06:03:16 +0000 (UTC)
X-Comment: SPF check N/A for local connections -
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=alchark@flipper.net; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 1EAB460649
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1EAB460649
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 1EAB460649
 for <u-boot@lists.u-boot-project.org>; Sun,  2 Aug 2026 06:03:16 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6E182844F6; Sun,  2 Aug 2026 08:03:14 +0200 (CEST)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4931780117
 for <u-boot@lists.denx.de>; Sun,  2 Aug 2026 08:03:12 +0200 (CEST)
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-6a0de062db5so265849a12.1
 for <u-boot@lists.denx.de>; Sat, 01 Aug 2026 23:03:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785650592; cv=none;
 d=google.com; s=arc-20260327;
 b=juLFmfmqYG7psyfN9HeZk1x8vU3ol9OGHZQaCteLlTdAEUs2dzXUL1HmsJzvcqAdsR
 12aHuNL/95ijEqlLIrvTVOAtLlFsHrEQloUwl8XHvDox5sEqRL9ij0KdB9STU4gk/DhA
 hLOWeOq0jOv9EWuBI6pv+LaQy+qeF/rVlLDcVcELcDrgMkMNKkQwQ1CH1O1E5QA/ThPH
 RQr4hwYTlsGAVncyAv1+xhHHpnIxmb6YG3MJYTM0wkUtNnxiN6+2566z4M3ie7rTaBv0
 20KT5yjD7HnsLB79ATBdgte58Z07CbJJQyLXs+RZm1rdjpzpMVPmI54wwDtSeWGM/9Po
 31ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=IbyTOOxQ+HRtvxnxSNpVTg5qymQ/avPY5grfP3j4rJI=;
 fh=Q0O95TDezeEBCPo26cc1LwIqWwdV8zxGdy1fwh73sTk=;
 b=MuV/SbTJ9jxquDIqVglaoQUly+WlT1AI/Vykh9bnKynQmElUa8v4HfNmwkvn0n2R5q
 zpmsiYyo3Lr8TT27+YXxii3uPaYPWYiH/PQp9V2n1r+hrMRCHfO2CdOdkg2HZI/0dRBd
 QbhHvUMe0fBt9RUvkJ9XzwsQuRhv7u/yx8rQGy7CJdYXjO2jgtUrP9/WCITWUItFacw1
 0HoWE+CoqT9m+AQb6f4ScImiQuWAegf44PX0d1mIxdqxSwZyah/z8dD48DQm854j5LQE
 VibKeraFPWICryGGDCY+fTHJvX0z3xYigtMM/fQcy123kppXdPtfFAVbuhIgPRr48BDQ
 gqsA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785650592; x=1786255392;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=IbyTOOxQ+HRtvxnxSNpVTg5qymQ/avPY5grfP3j4rJI=;
 b=QUAkJTmn5xdlmvaGVQMUGPHVtNhN4fiNbi1e84BZwv/rC+6ebYQrO5lBqQjK9ElKLW
 IepZKrZM+7+quvMg+xe3p/jgv3nA4hsyrYXNaaEn61u96/dFl/yE3GlOY6nR5rHara81
 UA4o2Qq9b2weauXnNRF+Y00bADSXz/pHUC+iBLxf/2y6rnB5juCmSjhFfXJqH/Sw5f8l
 h/z5va7m/+KtndAkLwrKRPEZ8M0O/kbgWxWEcMbUPNGSig7YytyVwpi4LKDexLCSKmoA
 RKclvWc1Kk6A19spamL0fxLz3YfRJMEZyQK5GNkFVE2ATP9SDoXEdgraJInCuP9cN7sz
 hwBQ==
X-Gm-Message-State: AOJu0YzPTEpvJ8JSQ8yYy8uIAT0Sxl43z+NBpWw5tRZjyk1hBAlij4S3
 SndJahLMk81Hg9aHYlw2Keu9yJGFC3AXci+TqobyuUtm7qPCuKAWE4LDsASKcnBWMhCsOeNGSiC
 fu50VlBSHw40WsIhdMBFWPwui22fzNxmXP3S/a78pVYxdvcQS7MhhvF4=
X-Gm-Gg: AR+sD114EG29NcGDYpEMbi+WN5EynOX8sW+FCpppiPd0dvR0lDQfMxkvVJNv+HKbD8+
 GXc2I6hXZUK2ushix5HvgblAgCknE4DiPWWHysBKBvD/J3KaQ4I4/EX986zBp73MkvHGSeYYE6X
 zqNXzxJJV2Cr6LTKW287/vflr/Tj1+xyywNApMwJF2vI7xqOnXlSc8p0VNz+R0wnQvouASPuh6a
 QaWpklQVYeOPOeZTosLMHZQ2zcyxKFuvyPQELAyphmDX/qODDwKXF+uyoQoCbAKuclBrKHLxZZ7
 qV8GvnG61nXrHMsWXCsPV00tZ8M0ndCsVK221k9oSCm+Gg==
X-Received: by 2002:a17:907:cb88:b0:c16:6608:bff7 with SMTP id
 a640c23a62f3a-c1fe8332e98mr410945566b.30.1785650591591; Sat, 01 Aug 2026
 23:03:11 -0700 (PDT)
MIME-Version: 1.0
References: <c8e57b678bee2394655ea5e7b0678fb300705e2f.1785649258.git.Munzzyy1@proton.me>
In-Reply-To: <c8e57b678bee2394655ea5e7b0678fb300705e2f.1785649258.git.Munzzyy1@proton.me>
From: Alexey Charkov <alchark@flipper.net>
Date: Sun, 2 Aug 2026 10:02:59 +0400
X-Gm-Features: AUfX_mz9mPF8wMThaKKrBDlbJ3S0hATkfate3sdrGzluiR-Iss3Bt1jrtP_1b0o
Message-ID: <CAKTNdwGCYjr+2vaBc6kArQokqTF=Gc23mF17B_22Fdcg1O=7hQ@mail.gmail.com>
Subject: Re: [PATCH] fs: btrfs: report file sizes from readdir
To: Cole Munz <Munzzyy1@proton.me>
Cc: u-boot@lists.denx.de, Qu Wenruo <quwenruo.btrfs@gmx.com>, 
 Marek Behun <kabel@kernel.org>, Tom Rini <trini@konsulko.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1785650592; x=1786255392; darn=lists.denx.de;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=IbyTOOxQ+HRtvxnxSNpVTg5qymQ/avPY5grfP3j4rJI=;
 b=3RjJ1ox7bAui0oj6zNbFiuC1A2y/PWy+GgKX0yci45YzHgxnowzvW4H990D2rgvvB2
 1HAq0+CW0l3L2tuAm4B05h9BMz7/DElRLARrJC4PKOHutciZPEgk795+lH0gEpKX+Q6r
 sQmSKlo40rqdKjbRQQXi1eMQbfLvA0RLqdAHtvQVMMf8MwW3s/PN3z1BnQpuDYBDVGAo
 VGUe1lgStCF18c1utDuMVKC07l9N7OOsgDb4pk4xWbQWw0naz2ehrS+TcTKsIo8XO/tx
 0iZ1g0OQH8sfWvE9nWsdUZC//GvEmzHOOeKBAYbWjjVnBJK3avW0ehrozwYC0f2B47nK
 0yNw==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 spf=fail smtp.mailfrom=flipper.net
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256
 header.s=google header.b=3RjJ1ox7
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=alchark@flipper.net
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=flipper.net header.i=@flipper.net header.b="3RjJ1ox7"; 
 dkim-atps=neutral
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi Cole,

On Sun, Aug 2, 2026 at 9:42=E2=80=AFAM Cole Munz <Munzzyy1@proton.me> wrote=
:
>
> btrfs_readdir() zeroes the dirent and fills in only the name and the
> type, so dent->size stays 0 and every file is listed as zero bytes:
>
>   =3D> ls host 0 /
>           0   f_192k.bin
>           0   small_3k.bin
>
> Reads themselves are fine, since btrfs_read() takes the size from
> btrfs_size(), which does its own inode item lookup. It affects EFI
> too: dir_read() in lib/efi_loader/efi_file.c copies dent->size into
> both file_size and physical_size, so an EFI application enumerating a
> directory on btrfs sees every file as empty, which is the generic-code
> path Alexey's readdir series moves btrfs onto.
>
> The custom listing that fs_ls_generic() replaced looked the inode item
> up and printed the real size, and every other filesystem in the tree
> fills dent->size in its own readdir: ext4fs.c:327, exfat io.c:805,
> erofs fs.c:186, squashfs sqfs.c:1095 and fat.c:1555.
>
> btrfs_next_dir_entry() already has the dir item mapped, so read the
> key it points at while we are there and hand it back to the caller,
> and use that to reach the inode item. A subvolume entry points at a
> root item instead and has no size of its own, so leave that one at 0.
>
>   =3D> ls host 0 /
>      196608   f_192k.bin
>        3000   small_3k.bin
>
> Fixes: 31cf3f177823 ("fs: btrfs: use fs_ls_generic() and drop custom impl=
ementation")
> Signed-off-by: Cole Munz <Munzzyy1@proton.me>
> ---
> The Fixes: commit is in Tom's tree, applied 2026-07-10 (b4-ty
> 178372904690.2905849.8798963092987519032.b4-ty@konsulko.com); it has not
> reached master yet, so that SHA will not resolve on a public clone today.
>
> Found by a btrfs test suite I am preparing for test/py; I will send that
> separately once the pending zstd inline extent fix is applied, since it
> depends on it.
>  fs/btrfs/btrfs.c    | 24 +++++++++++++++++++++++-
>  fs/btrfs/ctree.h    |  3 ++-
>  fs/btrfs/dir-item.c |  7 ++++++-
>  3 files changed, 31 insertions(+), 3 deletions(-)
>
> diff --git a/fs/btrfs/btrfs.c b/fs/btrfs/btrfs.c
> index e663dda12e80..b2856be0662f 100644
> --- a/fs/btrfs/btrfs.c
> +++ b/fs/btrfs/btrfs.c
> @@ -93,7 +93,10 @@ int btrfs_readdir(struct fs_dir_stream *fs_dirs, struc=
t fs_dirent **dentp)
>         struct btrfs_dir_stream *dirs =3D container_of(fs_dirs, struct bt=
rfs_dir_stream, parent);
>         struct btrfs_fs_info *fs_info =3D current_fs_info;
>         struct fs_dirent *dent =3D &dirs->dirent;
> +       struct btrfs_inode_item *ii;
>         struct btrfs_root *root;
> +       struct btrfs_path path;
> +       struct btrfs_key location;
>         struct btrfs_key key;
>         u8 type;
>         int ret;
> @@ -110,13 +113,32 @@ int btrfs_readdir(struct fs_dir_stream *fs_dirs, st=
ruct fs_dirent **dentp)
>
>         memset(dent, 0, sizeof(*dent));
>         ret =3D btrfs_next_dir_entry(root, dirs->ino, &dirs->offset, dent=
->name,
> -                                  sizeof(dent->name), &type);
> +                                  sizeof(dent->name), &type, &location);
>         if (ret < 0)
>                 return ret;
>         if (ret > 0)
>                 return -ENOENT;
>
>         dent->type =3D btrfs_dirent_type_to_fs_type(type);
> +
> +       /*
> +        * A subvolume entry points at a root item rather than an inode, =
and
> +        * has no size of its own.  Everything else carries one, and the =
fs
> +        * layer prints it, so look it up.
> +        */
> +       if (location.type =3D=3D BTRFS_INODE_ITEM_KEY) {
> +               btrfs_init_path(&path);
> +               ret =3D btrfs_search_slot(NULL, root, &location, &path, 0=
, 0);
> +               if (ret =3D=3D 0) {
> +                       ii =3D btrfs_item_ptr(path.nodes[0], path.slots[0=
],
> +                                           struct btrfs_inode_item);
> +                       dent->size =3D btrfs_inode_size(path.nodes[0], ii=
);
> +               }
> +               btrfs_release_path(&path);

The above repeats much of the calls that have just been done for this
exact entry several lines above inside btrfs_read_next_dir_enrty()

Can you perhaps refactor to avoid this repetition?

Best regards,
Alexey
