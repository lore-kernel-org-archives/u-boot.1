Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7A6CC55162
	for <u-boot@archiver.kernel.org>; Sun,  2 Aug 2026 06:48:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5A7D460600;
	Sun,  2 Aug 2026 06:48:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id C4Pz3jrr2EeG; Sun,  2 Aug 2026 06:48:17 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org BE72260617
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785653297;
	bh=U6IlWEdnpbauoullVz0Gttf/nL2zIxHIQFaG+1rOTEY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Gd3OEsKlC/6j/ND967Gleh2ij4x6X0JkNissOwwFUV9G8ce1LCwTgW01AcXETxPPm
	 v45pv/SGb+ctf90/XZadehzWr8k10S/3J5v3UuvN548fBlN27KQw8YMmTpVc0kjkn3
	 S7zpabNLTNssNFzt2btQj+logK+gxWQxBltjmMEvvQ+kis0Bi+86eTxGXRbqylUXyN
	 kfcW7Hw36S7JQhWxyeqCzDVlCIuwyQvYJHkFu4Q7H1gd7kcMibj8dn24yFquWrB07W
	 jL7aETlgXdTay0+b6pP1VNtZdmxE5hUaS42dTbABvu1P+cTnUOEPkJIN7NYulDFJBU
	 2d4lFTiDql4DQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id BE72260617;
	Sun,  2 Aug 2026 06:48:17 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 0E2FF26C
 for <u-boot@lists.u-boot-project.org>; Sun,  2 Aug 2026 06:48:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E814F406A3
 for <u-boot@lists.u-boot-project.org>; Sun,  2 Aug 2026 06:48:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Xumc1x5J-tHK for <u-boot@lists.u-boot-project.org>;
 Sun,  2 Aug 2026 06:48:15 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=quwenruo.btrfs@gmx.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 2DFDC406A2
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2DFDC406A2
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 2DFDC406A2
 for <u-boot@lists.u-boot-project.org>; Sun,  2 Aug 2026 06:48:11 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id D80CF844F6; Sun,  2 Aug 2026 08:48:09 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BC79780117
 for <u-boot@lists.denx.de>; Sun,  2 Aug 2026 08:48:07 +0200 (CEST)
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MoO24-1xIqz53eLQ-00ah3w; Sun, 02
 Aug 2026 08:48:04 +0200
Message-ID: <7bcd492f-7e1e-4fd9-970d-857ca5460ddd@gmx.com>
Date: Sun, 2 Aug 2026 16:17:59 +0930
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fs: btrfs: report file sizes from readdir
To: Alexey Charkov <alchark@flipper.net>, Cole Munz <Munzzyy1@proton.me>
Cc: u-boot@lists.denx.de, Marek Behun <kabel@kernel.org>,
 Tom Rini <trini@konsulko.com>
References: <c8e57b678bee2394655ea5e7b0678fb300705e2f.1785649258.git.Munzzyy1@proton.me>
 <CAKTNdwGCYjr+2vaBc6kArQokqTF=Gc23mF17B_22Fdcg1O=7hQ@mail.gmail.com>
Content-Language: en-US
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
Autocrypt: addr=quwenruo.btrfs@gmx.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNIlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT7CwJQEEwEIAD4CGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCZxF1YAUJEP5a
 sQAKCRDCPZHzoSX+qF+mB/9gXu9C3BV0omDZBDWevJHxpWpOwQ8DxZEbk9b9LcrQlWdhFhyn
 xi+l5lRziV9ZGyYXp7N35a9t7GQJndMCFUWYoEa+1NCuxDs6bslfrCaGEGG/+wd6oIPb85xo
 naxnQ+SQtYLUFbU77WkUPaaIU8hH2BAfn9ZSDX9lIxheQE8ZYGGmo4wYpnN7/hSXALD7+oun
 tZljjGNT1o+/B8WVZtw/YZuCuHgZeaFdhcV2jsz7+iGb+LsqzHuznrXqbyUQgQT9kn8ZYFNW
 7tf+LNxXuwedzRag4fxtR+5GVvJ41Oh/eygp8VqiMAtnFYaSlb9sjia1Mh+m+OBFeuXjgGlG
 VvQFzsBNBFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcga
 CbPEwhLj1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj
 /IrRUUka68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fN
 GSsRb+pKEKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0
 q1eW4Jrv0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEv
 ABEBAAHCwHwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCZxF1gQUJEP5a0gAK
 CRDCPZHzoSX+qHGpB/kB8A7M7KGL5qzat+jBRoLwB0Y3Zax0QWuANVdZM3eJDlKJKJ4HKzjo
 B2Pcn4JXL2apSan2uJftaMbNQbwotvabLXkE7cPpnppnBq7iovmBw++/d8zQjLQLWInQ5kNq
 Vmi36kmq8o5c0f97QVjMryHlmSlEZ2Wwc1kURAe4lsRG2dNeAd4CAqmTw0cMIrR6R/Dpt3ma
 +8oGXJOmwWuDFKNV4G2XLKcghqrtcRf2zAGNogg3KulCykHHripG3kPKsb7fYVcSQtlt5R6v
 HZStaZBzw4PcDiaAF3pPDBd+0fIKS6BlpeNRSFG94RYrt84Qw77JWDOAZsyNfEIEE0J6LSR/
In-Reply-To: <CAKTNdwGCYjr+2vaBc6kArQokqTF=Gc23mF17B_22Fdcg1O=7hQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:m8D+Brd3+/qaKlkjbqNPCsmKhM9TeMsZu3ONP/vJvdRk75oJkzH
 /99/5vC3JWDEGcplJlp8xGxM+7Dnl7yc5PFEXKICMGeH9/OiKyZjIzZkfXqh8cASsCuUEI9
 cfIVDUn7VxQ2tEkaVTW8R7Q+OP+uFg/xT2Hm9Uj/MkMcLfTfWy5M42jlNJVX3WKtb49AqWh
 Cr/NUEgYbam2rnKCeQ44Q==
UI-OutboundReport: notjunk:1;M01:P0:wUDuQl1e+U0=;sHzXqFzw9cZ3E9Iugb/BO9PxhB6
 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
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmx.com; 
 s=s31663417; t=1785653284; x=1786258084; i=quwenruo.btrfs@gmx.com;
 bh=U6IlWEdnpbauoullVz0Gttf/nL2zIxHIQFaG+1rOTEY=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=ufnPgwh708C1idQjCJk7wzjMC7iVjWa/5yN0SJTBmaAzEhoSdun0Ouf3uTFnAddM
 vvij3mFtT8nASSPgveDswnfooRe6snYMeSuM/NPL15Z94cfqaRfY3BEgU3bCiJVm6
 /aJaInx0io5dDzWhV8rtF6+rfvYQAXqL/Kf+hB3dTJcxYrnMlGRNOAURPOa2PzKfl
 J6uKIEc0UxJpusSj9Bxx/k4f7enEQS9CYqL6/veVYJ5mXQtQoutCxIMgFik9gw0iG
 +iODy39wKxpLy+U2dBCGD9KjdCQUe+iwiPkTNpiI1O+41yASlSL4ZlNtWBkZMNJyS
 tuTenF1nrWW70eH7YA==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=gmx.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 spf=fail smtp.mailfrom=gmx.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com
 header.a=rsa-sha256 header.s=s31663417 header.b=ufnPgwh7
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none)
 header.from=gmx.com
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=quwenruo.btrfs@gmx.com
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 secure) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="ufnPgwh7"; 
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



=E5=9C=A8 2026/8/2 15:32, Alexey Charkov =E5=86=99=E9=81=93:
> Hi Cole,
>=20
> On Sun, Aug 2, 2026 at 9:42=E2=80=AFAM Cole Munz <Munzzyy1@proton.me> wr=
ote:
>>
>> btrfs_readdir() zeroes the dirent and fills in only the name and the
>> type, so dent->size stays 0 and every file is listed as zero bytes:
>>
>>    =3D> ls host 0 /
>>            0   f_192k.bin
>>            0   small_3k.bin
>>
>> Reads themselves are fine, since btrfs_read() takes the size from
>> btrfs_size(), which does its own inode item lookup. It affects EFI
>> too: dir_read() in lib/efi_loader/efi_file.c copies dent->size into
>> both file_size and physical_size, so an EFI application enumerating a
>> directory on btrfs sees every file as empty, which is the generic-code
>> path Alexey's readdir series moves btrfs onto.
>>
>> The custom listing that fs_ls_generic() replaced looked the inode item
>> up and printed the real size, and every other filesystem in the tree
>> fills dent->size in its own readdir: ext4fs.c:327, exfat io.c:805,
>> erofs fs.c:186, squashfs sqfs.c:1095 and fat.c:1555.
>>
>> btrfs_next_dir_entry() already has the dir item mapped, so read the
>> key it points at while we are there and hand it back to the caller,
>> and use that to reach the inode item. A subvolume entry points at a
>> root item instead and has no size of its own, so leave that one at 0.
>>
>>    =3D> ls host 0 /
>>       196608   f_192k.bin
>>         3000   small_3k.bin
>>
>> Fixes: 31cf3f177823 ("fs: btrfs: use fs_ls_generic() and drop custom im=
plementation")
>> Signed-off-by: Cole Munz <Munzzyy1@proton.me>
>> ---
>> The Fixes: commit is in Tom's tree, applied 2026-07-10 (b4-ty
>> 178372904690.2905849.8798963092987519032.b4-ty@konsulko.com); it has no=
t
>> reached master yet, so that SHA will not resolve on a public clone toda=
y.
>>
>> Found by a btrfs test suite I am preparing for test/py; I will send tha=
t
>> separately once the pending zstd inline extent fix is applied, since it
>> depends on it.
>>   fs/btrfs/btrfs.c    | 24 +++++++++++++++++++++++-
>>   fs/btrfs/ctree.h    |  3 ++-
>>   fs/btrfs/dir-item.c |  7 ++++++-
>>   3 files changed, 31 insertions(+), 3 deletions(-)
>>
>> diff --git a/fs/btrfs/btrfs.c b/fs/btrfs/btrfs.c
>> index e663dda12e80..b2856be0662f 100644
>> --- a/fs/btrfs/btrfs.c
>> +++ b/fs/btrfs/btrfs.c
>> @@ -93,7 +93,10 @@ int btrfs_readdir(struct fs_dir_stream *fs_dirs, str=
uct fs_dirent **dentp)
>>          struct btrfs_dir_stream *dirs =3D container_of(fs_dirs, struct=
 btrfs_dir_stream, parent);
>>          struct btrfs_fs_info *fs_info =3D current_fs_info;
>>          struct fs_dirent *dent =3D &dirs->dirent;
>> +       struct btrfs_inode_item *ii;
>>          struct btrfs_root *root;
>> +       struct btrfs_path path;
>> +       struct btrfs_key location;
>>          struct btrfs_key key;
>>          u8 type;
>>          int ret;
>> @@ -110,13 +113,32 @@ int btrfs_readdir(struct fs_dir_stream *fs_dirs, =
struct fs_dirent **dentp)
>>
>>          memset(dent, 0, sizeof(*dent));
>>          ret =3D btrfs_next_dir_entry(root, dirs->ino, &dirs->offset, d=
ent->name,
>> -                                  sizeof(dent->name), &type);
>> +                                  sizeof(dent->name), &type, &location=
);
>>          if (ret < 0)
>>                  return ret;
>>          if (ret > 0)
>>                  return -ENOENT;
>>
>>          dent->type =3D btrfs_dirent_type_to_fs_type(type);
>> +
>> +       /*
>> +        * A subvolume entry points at a root item rather than an inode=
, and
>> +        * has no size of its own.  Everything else carries one, and th=
e fs
>> +        * layer prints it, so look it up.
>> +        */
>> +       if (location.type =3D=3D BTRFS_INODE_ITEM_KEY) {
>> +               btrfs_init_path(&path);
>> +               ret =3D btrfs_search_slot(NULL, root, &location, &path,=
 0, 0);
>> +               if (ret =3D=3D 0) {
>> +                       ii =3D btrfs_item_ptr(path.nodes[0], path.slots=
[0],
>> +                                           struct btrfs_inode_item);
>> +                       dent->size =3D btrfs_inode_size(path.nodes[0], =
ii);
>> +               }
>> +               btrfs_release_path(&path);
>=20
> The above repeats much of the calls that have just been done for this
> exact entry several lines above inside btrfs_read_next_dir_enrty()
>=20
> Can you perhaps refactor to avoid this repetition?

Sorry I didn't see the point.

The function btrfs_read_next_dirty_entry() is search the key inside the=20
parent directory.

Meanwhile this one is search for the inode item of the child entry.

They are completely different and I didn't see why "refactor" can improve.

In fact, this version is much simpler:

  fs/btrfs/btrfs.c    | 24 +++++++++++++++++++++++-
  fs/btrfs/ctree.h    |  3 ++-
  fs/btrfs/dir-item.c |  7 ++++++-
  3 files changed, 31 insertions(+), 3 deletions(-)

Compared to the v2:

  fs/btrfs/btrfs.c    | 75 +++++++++++++++++++++++++++++++--------------
  fs/btrfs/ctree.h    |  3 +-
  fs/btrfs/dir-item.c |  7 ++++-
  3 files changed, 60 insertions(+), 25 deletions(-)

Thanks,
Qu
>=20
> Best regards,
> Alexey

