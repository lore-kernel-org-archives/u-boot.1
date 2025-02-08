Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2133C02198
	for <u-boot@archiver.kernel.org>; Sat,  8 Feb 2025 21:22:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4B08A80805;
	Sat,  8 Feb 2025 22:22:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="TuxlUJrm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 29E4580834; Sat,  8 Feb 2025 22:22:51 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E8698807FE
 for <u-boot@lists.denx.de>; Sat,  8 Feb 2025 22:22:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1739049766; x=1739654566; i=xypron.glpk@gmx.de;
 bh=V3WE6barQdURA5qJCBypIWky/GgoBM8wRf+sUn031dI=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
 cc:content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=TuxlUJrmDQhxbk+CPsRs2wvqStMvIc17NlmyVbhdJGhFNtRTUxjVaQJKBGLYOZHc
 oVtvH7O8Ig3EmkZ4w3VBL0hR8k4Gp9GGxlEGFzVjl3lfB6NoLEFTW/SlUKxQ8G5b7
 7qsHKyo0PBxdgcl7OZW2QfhLKz6ski8wYvLqwbUNmhxT2yM9GWSmfWGLIrDo/FI+N
 /+eTc92Zl4gsfniRoB1huGBCaedLBq7AOyVkdMQAOsxEJ3iN8YtS6QSSPo0NiSaRX
 9qs/zKT8+lI1PNytD+izEMH38vJSxDVZV8BSNyZuV4Eclr8WmZt1vJ6mdCIPldZyF
 0R7W9NoUyPXRvvRvbg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.161] ([5.147.80.91]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MNbkv-1u4BXJ1Val-00HxFT; Sat, 08
 Feb 2025 22:22:46 +0100
Message-ID: <c991fbe5-bde5-4268-aad7-6c7513cce01b@gmx.de>
Date: Sat, 8 Feb 2025 22:22:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/6] fs: fat: Support basic file rename
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Daniel Venzin <Daniel.Venzin@mt.com>
Cc: burak@gerz.io, gabriel.dalimonte@gmail.com, Manuel.Traut@mt.com,
 Baruch Siach <baruch@tkos.co.il>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Nam Cao <namcao@linutronix.de>, Simon Glass <sjg@chromium.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
References: <20250207124523.85026-1-Daniel.Venzin@mt.com>
 <20250207124523.85026-5-Daniel.Venzin@mt.com>
 <fdbd0ef3-240a-4d5e-a1c5-34d5861faf0f@gmx.de>
Content-Language: en-US
In-Reply-To: <fdbd0ef3-240a-4d5e-a1c5-34d5861faf0f@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:AbmPdkpeGKJ8vfzTQLS2DrJb66cSlL5zI7YdB+Z5f5o6wVPfTuD
 hgvdMkbKVkWJCW2JrCAYnuB9jxr1raUgo+CFR2szo6fWTglKiGeSo8G05xr0WmK6NjxzYdu
 KbD59UrcvnXdyxqSjmz5cKIyZ+EHa17e0BIvZEyoYvM54rkyLKpGPfMA3eFveVmsfgZ1Gvs
 TOfXT1Di7/o4dTcWTvwbg==
UI-OutboundReport: notjunk:1;M01:P0:hpOhUqiBMew=;5/3NRuQp0dW63dmjAV/Ks+orhMl
 sOPC5FY4/QUdbAqZUAiAhtjanclYagqeuW9wq2fkGhFwowOmGAgqth1NkCmq+81TcZgexr/ls
 CtOqE7xFR/2MdZSr+MsuqEFnIhsQZXyIKQ67jO/Oddw3/V1DBtUDECVqGdYSL/1+Or0K3Rzgn
 Kwga/lwUNyuHqaHplGaeXvM7491JDBq27xaqJGeISmIgt+oT/bgZSphUlmOFKmvvsbSWebkIL
 +sI5V06XsA0q1RaszOa5Mf5uy/kiuCMJryk7YnifAcHxf9Ie5DJW5qb8/J3GAR7tDZ7TW4mKW
 zpQBNMKnT1y2onB+9Xw7xDxmv+6+xMNVof0fIEJvSxsaBt7xHtYa2y1aGmHfVHC1envcDINfW
 llBQyev4i+TH1XHa266IlAbHIsybqDIMzdOVQ6aCc5N1+tArJ36MWN6rTO4AXCSAQEt2TEQCs
 atC4wrdZbw2XAEV8lT36ouPXe843htslspY2t18dwkF6fZJFWqDnWDQ7lDrOT5jZQgPzuAbye
 jcStCqeH7tkbcb8kNxqjG/foK7hwp72Jbza4/mk5OBFu7bGiD9xsXxg89Qvock2iglPGr7tCv
 B9+lLHUhdcoWs3znyyMUrkmsLbRoXcqkCMyowjzuMp4nuDN7wTcC3HFF4a0Sw+FbT1EDCNDhz
 bEAsgcRXDjQ7gk32njEFoEBaMk7M3O0psz39DW2rvo90Zqfe4350PcLM+LXiNoSqyyjKJLolG
 kOBXxKVYdiAD/tYxB2bLuMQ4Mkt3yqzeUqJTeb+d3iKZUvcTvmaU5c88y8nKkoixgueUwEwQu
 8YqVQh1dS7XfCjvx7yt6pD9TFQyT9/+8wPqDczC05c5//qqbpM01hIGgRP9Y7MkbMZAbjEbLJ
 kcmzwKG7wZRWElXnq0bQEpgVviBGWA+Ndy9Gp/xxoN3FT8ZMAHQJPoT69acXvBVU2Y+59s788
 +wg2vfTpgA5xhEmt3YReLBK8yvvScnOj762TXxfLisWPd+IXJFtqkVYjw2LZrOmqHM3FN244i
 50HviDG6Zy6m4yeRUTJR99/zEmJW2V+aoErSDo5Y0Gh+vNbjO1WJ0qElo/qQC3jwM6ueYezf4
 en0Kh9A+GGy30reFbJWybpDRigZOeawo/YjtEeicyo5TO+BwetngfRr2FTlfRDzCFAVPMu2su
 +vMmIc0hbMgW6+8Gz+KEJnZiE++P7EJmRgRpKnEGBz3Z7obira+SIEmLhRUimCD4zg10liAYs
 4qxnALOS4idyDvNWiMicZD3PBC+RDrAGB2tRzx0wQyD/OPyexHZd64n+110RH2XiNniqZeXQs
 TAiuHN/pqpHvCtgu4fXBkycyotsij13Z0BhA8WPoKKcgNMyjuD1XkdV0MkrT9ypDw+l99i1eK
 Su86B7Sltv7+66PsK3SHiAigK9HUn9E2ebkymuWp1DJeX1PXD7UKgtnwA2
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

On 2/8/25 22:20, Heinrich Schuchardt wrote:
> On 2/7/25 13:45, Daniel Venzin wrote:
>> This implementation currently does not support
>> moving files between directories.
>
> Why would we make such a restriction?
>
>>
>> Signed-off-by: Daniel Venzin <Daniel.Venzin@mt.com>
>>
>> ---
>>
>> Changes in v3:
>> - Abort the rename if the destination is a path instead of a file
>>
>> Changes in v2:
>> - Separate the rename implementation from changes in the filesystem lay=
er
>> - Eliminate code duplication with delete_dentry_long(..)
>> - Ensure that the source file exists, but not the destination file
>> - Free the fatbuf if it has been reinitialized with fat_itr_root
>> - Delete orphaned FAT entry after copying file metadata
>>
>> =C2=A0 fs/fat/fat_write.c | 125 +++++++++++++++++++++++++++++++++++++++=
++++++
>> =C2=A0 fs/fs.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 |=C2=A0=C2=A0 2 +-
>> =C2=A0 include/fat.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 1 +
>> =C2=A0 3 files changed, 127 insertions(+), 1 deletion(-)
>>
>> diff --git a/fs/fat/fat_write.c b/fs/fat/fat_write.c
>> index c78b80e0b7a..6e4ff7c57d4 100644
>> --- a/fs/fat/fat_write.c
>> +++ b/fs/fat/fat_write.c
>> @@ -1821,3 +1821,128 @@ exit:
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 free(dotdent);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ret;
>> =C2=A0 }
>> +
>> +int file_fat_rename(const char *path, const char *new_fname)
>
> Below you are expecting that new_fname is a path not only a file name.
>
> %s/new_fname/new_path/
>
>> +{
>> +=C2=A0=C2=A0=C2=A0 fsdata datablock =3D { .fatbuf =3D NULL, };
>> +=C2=A0=C2=A0=C2=A0 fat_itr *itr =3D NULL;
>> +
>> +=C2=A0=C2=A0=C2=A0 dir_entry *dentry;
>> +
>> +=C2=A0=C2=A0=C2=A0 char new_path[VFAT_MAXLEN_BYTES];
>> +=C2=A0=C2=A0=C2=A0 char *new_fname_copy =3D NULL, *new_fname_dirname,
>> *new_fname_basename;
>> +=C2=A0=C2=A0=C2=A0 char *path_copy =3D NULL, *path_dirname, *path_base=
name;
>> +
>> +=C2=A0=C2=A0=C2=A0 loff_t actwrite;
>> +
>> +=C2=A0=C2=A0=C2=A0 __u16 starthi, start;
>> +=C2=A0=C2=A0=C2=A0 __u32 size, entry;
>> +
>> +=C2=A0=C2=A0=C2=A0 int ret =3D -1;
>> +
>> +=C2=A0=C2=A0=C2=A0 new_fname_copy =3D strdup(new_fname);
>> +=C2=A0=C2=A0=C2=A0 if (!new_fname_copy)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto exit;
>> +
>> +=C2=A0=C2=A0=C2=A0 split_filename(new_fname_copy, &new_fname_dirname,
>> &new_fname_basename);
>> +
>> +=C2=A0=C2=A0=C2=A0 if (strlen(new_fname_dirname) > 1 ||
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (strcmp(new_fname_dirname, =
"/") !=3D 0 &&
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 strcmp(new_fname_dirn=
ame, ".") !=3D 0)) {
>
> No clue, why you expect "/" or "." at the beginning of a path.
> In U-Boot file paths are always relative to the root directory.
>
> Shouldn't fat_itr_resolve() take care of checking the validity of the pa=
th?
>
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D -EINVAL;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto exit;
>> +=C2=A0=C2=A0=C2=A0 }
>> +
>> +=C2=A0=C2=A0=C2=A0 path_copy =3D strdup(path);
>> +=C2=A0=C2=A0=C2=A0 if (!path_copy)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto exit;
>> +
>> +=C2=A0=C2=A0=C2=A0 split_filename(path_copy, &path_dirname, &path_base=
name);
>> +=C2=A0=C2=A0=C2=A0 snprintf(new_path, sizeof(new_path), "%s/%s", path_=
dirname,
>> new_fname_basename);
>
> You already determined new_fname_dirname. You must not ignore it.
> You should delete above statement.
>
>> +
>> +=C2=A0=C2=A0=C2=A0 if (!fat_exists(path)) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D -ENOENT;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto exit;
>> +=C2=A0=C2=A0=C2=A0 }
>> +
>> +=C2=A0=C2=A0=C2=A0 if (fat_exists(new_path)) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D -EEXIST;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto exit;
>> +=C2=A0=C2=A0=C2=A0 }

Please, do not iterate multiple times over the same paths. You already
call far_itr_resolve() below.

Best regards

Heinrich


>> +
>> +=C2=A0=C2=A0=C2=A0 ret =3D file_fat_write(new_path, &actwrite, 0, 0, &=
actwrite);
>> +=C2=A0=C2=A0=C2=A0 if (ret)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto exit;
>> +
>> +=C2=A0=C2=A0=C2=A0 itr =3D malloc_cache_aligned(sizeof(*itr));
>> +=C2=A0=C2=A0=C2=A0 if (!itr) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D -ENOMEM;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto exit;
>> +=C2=A0=C2=A0=C2=A0 }
>> +
>> +=C2=A0=C2=A0=C2=A0 ret =3D fat_itr_root(itr, &datablock);
>> +=C2=A0=C2=A0=C2=A0 if (ret)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto exit;
>> +
>> +=C2=A0=C2=A0=C2=A0 ret =3D fat_itr_resolve(itr, path, TYPE_FILE);
>
> Why don't we allow renaming of directories?
>
> TYPE_FILE | TYPE_DIR
>
>> +=C2=A0=C2=A0=C2=A0 if (ret)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto exit;
>> +
>> +=C2=A0=C2=A0=C2=A0 dentry =3D itr->dent;
>> +
>> +=C2=A0=C2=A0=C2=A0 starthi =3D dentry->starthi;
>> +=C2=A0=C2=A0=C2=A0 start =3D dentry->start;
>> +=C2=A0=C2=A0=C2=A0 size =3D dentry->size;
>> +
>> +=C2=A0=C2=A0=C2=A0 free(datablock.fatbuf);
>> +=C2=A0=C2=A0=C2=A0 datablock.fatbuf =3D NULL;
>> +
>> +=C2=A0=C2=A0=C2=A0 ret =3D fat_itr_root(itr, &datablock);
>> +=C2=A0=C2=A0=C2=A0 if (ret)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto exit;
>> +
>> +=C2=A0=C2=A0=C2=A0 ret =3D fat_itr_resolve(itr, new_path, TYPE_FILE);
>
> This would not detect if new_path points to an existing or non-existing
> directory.
>
> Check that new_fname_dirname exists and then use the same itr to check
> that new_fname_dirname/new_basename does not exist.
>
> This avoids iterating once here and once in fat_rename().
>
>> +=C2=A0=C2=A0=C2=A0 if (ret)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto exit;
>
> We don't want to overwrite existing files or directories. Don't we
> expect -ENOENT or -ENOTDIR here?
>
>> +
>> +=C2=A0=C2=A0=C2=A0 dentry =3D itr->dent;
>> +
>> +=C2=A0=C2=A0=C2=A0 fsdata *mydata =3D itr->fsdata;
>> +
>> +=C2=A0=C2=A0=C2=A0 entry =3D START(dentry);
>> +
>> +=C2=A0=C2=A0=C2=A0 dentry->starthi =3D starthi;
>> +=C2=A0=C2=A0=C2=A0 dentry->start =3D start;
>> +=C2=A0=C2=A0=C2=A0 dentry->size =3D size;
>> +
>> +=C2=A0=C2=A0=C2=A0 ret =3D flush_dir(itr);
>> +=C2=A0=C2=A0=C2=A0 if (ret)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto exit;
>> +
>> +=C2=A0=C2=A0=C2=A0 clear_fatent(mydata, entry);
>> +=C2=A0=C2=A0=C2=A0 if (flush_dirty_fat_buffer(mydata) < 0) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 printf("Error: flush fat bu=
ffer\n");
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D -EIO;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto exit;
>> +=C2=A0=C2=A0=C2=A0 }
>> +
>> +=C2=A0=C2=A0=C2=A0 free(datablock.fatbuf);
>> +=C2=A0=C2=A0=C2=A0 datablock.fatbuf =3D NULL;
>> +
>> +=C2=A0=C2=A0=C2=A0 ret =3D fat_itr_root(itr, &datablock);
>> +=C2=A0=C2=A0=C2=A0 if (ret)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto exit;
>> +
>> +=C2=A0=C2=A0=C2=A0 ret =3D fat_itr_resolve(itr, path, TYPE_FILE);
>> +=C2=A0=C2=A0=C2=A0 if (ret)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto exit;
>
> Why don't you use separate variables for the old and the new itr value?
> Then you would not have to resolve the old path twice.
>
> Best regards
>
> Heinrich
>
>> +
>> +=C2=A0=C2=A0=C2=A0 ret =3D delete_dentry_long(itr, FATENT_CLEAR_SKIP);=
> +
>> +exit:
>> +=C2=A0=C2=A0=C2=A0 free(new_fname_copy);
>> +=C2=A0=C2=A0=C2=A0 free(path_copy);
>> +=C2=A0=C2=A0=C2=A0 free(datablock.fatbuf);
>> +=C2=A0=C2=A0=C2=A0 free(itr);
>> +=C2=A0=C2=A0=C2=A0 return ret;
>> +}
>> diff --git a/fs/fs.c b/fs/fs.c
>> index b746d05ebcd..3576d5c6644 100644
>> --- a/fs/fs.c
>> +++ b/fs/fs.c
>> @@ -208,7 +208,7 @@ static struct fstype_info fstypes[] =3D {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .write =3D file_=
fat_write,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .unlink =3D fat_=
unlink,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .mkdir =3D fat_m=
kdir,
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .rename =3D fs_rename_unsup=
ported,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .rename =3D file_fat_rename=
,
>> =C2=A0 #else
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .write =3D fs_wr=
ite_unsupported,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .unlink =3D fs_u=
nlink_unsupported,
>> diff --git a/include/fat.h b/include/fat.h
>> index 3dce99a23cf..415ebd7b7c8 100644
>> --- a/include/fat.h
>> +++ b/include/fat.h
>> @@ -207,6 +207,7 @@ int fat_readdir(struct fs_dir_stream *dirs, struct
>> fs_dirent **dentp);
>> =C2=A0 void fat_closedir(struct fs_dir_stream *dirs);
>> =C2=A0 int fat_unlink(const char *filename);
>> =C2=A0 int fat_mkdir(const char *dirname);
>> +int file_fat_rename(const char *path, const char *new_filename);
>> =C2=A0 void fat_close(void);
>> =C2=A0 void *fat_next_cluster(fat_itr *itr, unsigned int *nbytes);
>>
>

