Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A6CDC4828F
	for <u-boot@archiver.kernel.org>; Fri,  9 Feb 2024 09:56:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A23D087E60;
	Fri,  9 Feb 2024 10:56:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=foundries.io
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=foundries.io header.i=@foundries.io header.b="cSY3S93t";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A56BB87E63; Fri,  9 Feb 2024 10:56:36 +0100 (CET)
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com
 [IPv6:2a00:1450:4864:20::12b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0473A87E56
 for <u-boot@lists.denx.de>; Fri,  9 Feb 2024 10:56:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=foundries.io
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=igor.opaniuk@foundries.io
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-5116ec49081so788504e87.2
 for <u-boot@lists.denx.de>; Fri, 09 Feb 2024 01:56:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=foundries.io; s=google; t=1707472593; x=1708077393; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HvnAr+dBVFVMlJXDeKTt6WKkmK5nqxrr9CGdDICc/0w=;
 b=cSY3S93t+BVUxbuR0eT+0OPOsMItfejFq3lMcRBDhv7Dwxbl6KvbqAg9C+HAY68HPl
 9KqtKsNPBoTikjf7MGWi0N/YKVeLlKdiC8PcE/6Lo/I1QgO8etzayUwk+vYodM7jcr2e
 Ed3GV3yis3GLDQqAhYykpRPobr3lkSw9Zp9eTyBB4zgpyLb9PX8jqBXcGeze3frsNTKz
 81X5wmYkjvLt9IXaPviuCs1zmV+aQtcC9gFgRvPfP6EzEVXkde2+fGbNKrHzQk+QfS2H
 6DQMJ1cZs4FuJ2rXPrjAszKzF3U79juAoURT6I+F8Bqtu7yZ7qpV1rYN656DA1y61gZn
 bf/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707472593; x=1708077393;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HvnAr+dBVFVMlJXDeKTt6WKkmK5nqxrr9CGdDICc/0w=;
 b=kAGOAHHG+jy2iIYXyPE4TJtYl0tLWW3FabB/QEC3/ZSAMXzkZ2i1oSz7O9xkhszwBA
 AtjUe3+VWdrnUaDKsyMte33ADoPVNmX/Vz3UNhn/N4ihO8fAZbe3sJCpGEGoDcyCAtJ1
 V9tdkXpZu7a20itCciKy7Hm1xMk7zM3+aQnRzF67ZKfAGvxiiD17Yl/fTY7DWreGd7pa
 JmynmwU8eOT/3cHv+F8jq6yFbcPNDxDCSoMez803HZygEi7S1C2OddUcoS+WsuFVk/7P
 Bizo8jBjFD4A07UF6Ky+Xg6a3ZdLyU38iNZmPkPO3lm2hIU3oVMUSi3Ta/G6GZhB7wr0
 N3Nw==
X-Gm-Message-State: AOJu0YzQs3NT7TKDLRTJGQnLNI+enw2Fr8SKXE0r90yDtawOpuUD6skP
 RUul5b1lDx+/Gm36HRQUColM/ffihUevBtSfGI9ZCzJSNcP9ydjdX/U7eCS0pTWEP/6M1ci1bmx
 2KSl9zvgzmUQZm456JhG7b3s3EtS9QmSZImkwnw==
X-Google-Smtp-Source: AGHT+IG3rG/DuweYXhERJlMG2g4ooXEhrEfpiVSIszMJEKvIx9AGR55B6gcAlnRTWMD+O/+pu9BPA2THl7oEyRv31Ug=
X-Received: by 2002:a05:6512:3d0a:b0:511:5b53:8158 with SMTP id
 d10-20020a0565123d0a00b005115b538158mr982018lfv.54.1707472593235; Fri, 09 Feb
 2024 01:56:33 -0800 (PST)
MIME-Version: 1.0
References: <20240206223153.3060433-1-igor.opaniuk@foundries.io>
 <20240206223153.3060433-5-igor.opaniuk@foundries.io>
 <875xyzjbt0.fsf@baylibre.com>
In-Reply-To: <875xyzjbt0.fsf@baylibre.com>
From: Igor Opaniuk <igor.opaniuk@foundries.io>
Date: Fri, 9 Feb 2024 10:56:22 +0100
Message-ID: <CAL6CDMHKL1+iv0aeh=1iNQHpbMs1Bb1hX=uV_V0t2_haJML53A@mail.gmail.com>
Subject: Re: [PATCH v1 4/7] cmd: avb: rework prints
To: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Cc: u-boot@lists.denx.de, Igor Opaniuk <igor.opaniuk@gmail.com>, 
 Tom Rini <trini@konsulko.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hi Mattijs,

On Thu, Feb 8, 2024 at 3:00=E2=80=AFPM Mattijs Korpershoek
<mkorpershoek@baylibre.com> wrote:
>
> Hi Igor,
>
> Thank you for the patch.
>
> On mar., f=C3=A9vr. 06, 2024 at 23:31, Igor Opaniuk <igor.opaniuk@foundri=
es.io> wrote:
>
> > From: Igor Opaniuk <igor.opaniuk@gmail.com>
> >
> > Introduce AVB_OPS_CHECK macro for checking AvbOps before using
> > it to avoid code duplication.
> > Simplify and add more context for prints where it's needed.
> >
> > Signed-off-by: Igor Opaniuk <igor.opaniuk@gmail.com>
> > ---
> >
> >  cmd/avb.c | 156 ++++++++++++++++++++++++++++--------------------------
> >  1 file changed, 80 insertions(+), 76 deletions(-)
> >
> > diff --git a/cmd/avb.c b/cmd/avb.c
> > index ce8b63873f2..ae0012c0e79 100644
> > --- a/cmd/avb.c
> > +++ b/cmd/avb.c
> > @@ -11,6 +11,14 @@
> >  #include <mmc.h>
> >
> >  #define AVB_BOOTARGS "avb_bootargs"
> > +
> > +#define AVB_OPS_CHECK(avb_ops) do { \
> > +     if (!(avb_ops)) { \
> > +             printf("AVB is not initialized, please run 'avb init <id>=
'\n"); \
> > +             return CMD_RET_FAILURE; \
> > +     } \
> > +} while (false)
> > +
> checkpatch.pl --u-boot seems to complain about this:
> WARNING: Macros with flow control statements should be avoided
> #25: FILE: cmd/avb.c:15:
>
> This seems documented in the kernel coding style as well.
> https://www.kernel.org/doc/html/latest/process/coding-style.html#macros-e=
nums-and-rtl
>
> I'd argue that in this case, it's not better or worse in terme of
> readability but i'd prefer to stick to the rules in this case.
>
> The error handling (using ret) and the better prints seem fine though.
> Could we drop the AVB_OPS_CHECK macro for v2?
Yeah, I was just trying to find a tradeoff between readability/code duplica=
tion
and coding style.

Will drop it in v2. Thanks!

>
> >  static struct AvbOps *avb_ops;
> >
> >  int do_avb_init(struct cmd_tbl *cmdtp, int flag, int argc, char *const=
 argv[])
> > @@ -28,8 +36,10 @@ int do_avb_init(struct cmd_tbl *cmdtp, int flag, int=
 argc, char *const argv[])
> >       avb_ops =3D avb_ops_alloc(mmc_dev);
> >       if (avb_ops)
> >               return CMD_RET_SUCCESS;
> > +     else
> > +             printf("Can't allocate AvbOps");
> >
> > -     printf("Failed to initialize avb2\n");
> > +     printf("Failed to initialize AVB\n");
> >
> >       return CMD_RET_FAILURE;
> >  }
> > @@ -41,11 +51,9 @@ int do_avb_read_part(struct cmd_tbl *cmdtp, int flag=
, int argc,
> >       s64 offset;
> >       size_t bytes, bytes_read =3D 0;
> >       void *buffer;
> > +     int ret;
> >
> > -     if (!avb_ops) {
> > -             printf("AVB 2.0 is not initialized, please run 'avb init'=
\n");
> > -             return CMD_RET_USAGE;
> > -     }
> > +     AVB_OPS_CHECK(avb_ops);
> >
> >       if (argc !=3D 5)
> >               return CMD_RET_USAGE;
> > @@ -55,14 +63,15 @@ int do_avb_read_part(struct cmd_tbl *cmdtp, int fla=
g, int argc,
> >       bytes =3D hextoul(argv[3], NULL);
> >       buffer =3D (void *)hextoul(argv[4], NULL);
> >
> > -     if (avb_ops->read_from_partition(avb_ops, part, offset, bytes,
> > -                                      buffer, &bytes_read) =3D=3D
> > -                                      AVB_IO_RESULT_OK) {
> > +     ret =3D avb_ops->read_from_partition(avb_ops, part, offset,
> > +                                        bytes, buffer, &bytes_read);
> > +     if (ret =3D=3D AVB_IO_RESULT_OK) {
> >               printf("Read %zu bytes\n", bytes_read);
> >               return CMD_RET_SUCCESS;
> >       }
> >
> > -     printf("Failed to read from partition\n");
> > +     printf("Failed to read from partition '%s', err =3D %d\n",
> > +            part, ret);
> >
> >       return CMD_RET_FAILURE;
> >  }
> > @@ -74,11 +83,9 @@ int do_avb_read_part_hex(struct cmd_tbl *cmdtp, int =
flag, int argc,
> >       s64 offset;
> >       size_t bytes, bytes_read =3D 0;
> >       char *buffer;
> > +     int ret;
> >
> > -     if (!avb_ops) {
> > -             printf("AVB 2.0 is not initialized, please run 'avb init'=
\n");
> > -             return CMD_RET_USAGE;
> > -     }
> > +     AVB_OPS_CHECK(avb_ops);
> >
> >       if (argc !=3D 4)
> >               return CMD_RET_USAGE;
> > @@ -94,8 +101,9 @@ int do_avb_read_part_hex(struct cmd_tbl *cmdtp, int =
flag, int argc,
> >       }
> >       memset(buffer, 0, bytes);
> >
> > -     if (avb_ops->read_from_partition(avb_ops, part, offset, bytes, bu=
ffer,
> > -                                      &bytes_read) =3D=3D AVB_IO_RESUL=
T_OK) {
> > +     ret =3D avb_ops->read_from_partition(avb_ops, part, offset,
> > +                                        bytes, buffer, &bytes_read);
> > +     if (ret =3D=3D AVB_IO_RESULT_OK) {
> >               printf("Requested %zu, read %zu bytes\n", bytes, bytes_re=
ad);
> >               printf("Data: ");
> >               for (int i =3D 0; i < bytes_read; i++)
> > @@ -107,7 +115,8 @@ int do_avb_read_part_hex(struct cmd_tbl *cmdtp, int=
 flag, int argc,
> >               return CMD_RET_SUCCESS;
> >       }
> >
> > -     printf("Failed to read from partition\n");
> > +     printf("Failed to read from partition '%s', err =3D %d\n",
> > +            part, ret);
> >
> >       free(buffer);
> >       return CMD_RET_FAILURE;
> > @@ -120,11 +129,9 @@ int do_avb_write_part(struct cmd_tbl *cmdtp, int f=
lag, int argc,
> >       s64 offset;
> >       size_t bytes;
> >       void *buffer;
> > +     int ret;
> >
> > -     if (!avb_ops) {
> > -             printf("AVB 2.0 is not initialized, run 'avb init' first\=
n");
> > -             return CMD_RET_FAILURE;
> > -     }
> > +     AVB_OPS_CHECK(avb_ops);
> >
> >       if (argc !=3D 5)
> >               return CMD_RET_USAGE;
> > @@ -134,13 +141,15 @@ int do_avb_write_part(struct cmd_tbl *cmdtp, int =
flag, int argc,
> >       bytes =3D hextoul(argv[3], NULL);
> >       buffer =3D (void *)hextoul(argv[4], NULL);
> >
> > -     if (avb_ops->write_to_partition(avb_ops, part, offset, bytes, buf=
fer) =3D=3D
> > -         AVB_IO_RESULT_OK) {
> > +     ret =3D avb_ops->write_to_partition(avb_ops, part, offset,
> > +                                       bytes, buffer);
> > +     if (ret =3D=3D AVB_IO_RESULT_OK) {
> >               printf("Wrote %zu bytes\n", bytes);
> >               return CMD_RET_SUCCESS;
> >       }
> >
> > -     printf("Failed to write in partition\n");
> > +     printf("Failed to write in partition '%s', err =3D %d\n",
> > +            part, ret);
> >
> >       return CMD_RET_FAILURE;
> >  }
> > @@ -150,24 +159,23 @@ int do_avb_read_rb(struct cmd_tbl *cmdtp, int fla=
g, int argc,
> >  {
> >       size_t index;
> >       u64 rb_idx;
> > +     int ret;
> >
> > -     if (!avb_ops) {
> > -             printf("AVB 2.0 is not initialized, run 'avb init' first\=
n");
> > -             return CMD_RET_FAILURE;
> > -     }
> > +     AVB_OPS_CHECK(avb_ops);
> >
> >       if (argc !=3D 2)
> >               return CMD_RET_USAGE;
> >
> >       index =3D (size_t)hextoul(argv[1], NULL);
> >
> > -     if (avb_ops->read_rollback_index(avb_ops, index, &rb_idx) =3D=3D
> > -         AVB_IO_RESULT_OK) {
> > +     ret =3D avb_ops->read_rollback_index(avb_ops, index, &rb_idx);
> > +     if (ret =3D=3D AVB_IO_RESULT_OK) {
> >               printf("Rollback index: %llx\n", rb_idx);
> >               return CMD_RET_SUCCESS;
> >       }
> >
> > -     printf("Failed to read rollback index\n");
> > +     printf("Failed to read rollback index id =3D %zu, err =3D %d\n",
> > +            index, ret);
> >
> >       return CMD_RET_FAILURE;
> >  }
> > @@ -177,11 +185,9 @@ int do_avb_write_rb(struct cmd_tbl *cmdtp, int fla=
g, int argc,
> >  {
> >       size_t index;
> >       u64 rb_idx;
> > +     int ret;
> >
> > -     if (!avb_ops) {
> > -             printf("AVB 2.0 is not initialized, run 'avb init' first\=
n");
> > -             return CMD_RET_FAILURE;
> > -     }
> > +     AVB_OPS_CHECK(avb_ops);
> >
> >       if (argc !=3D 3)
> >               return CMD_RET_USAGE;
> > @@ -189,11 +195,12 @@ int do_avb_write_rb(struct cmd_tbl *cmdtp, int fl=
ag, int argc,
> >       index =3D (size_t)hextoul(argv[1], NULL);
> >       rb_idx =3D hextoul(argv[2], NULL);
> >
> > -     if (avb_ops->write_rollback_index(avb_ops, index, rb_idx) =3D=3D
> > -         AVB_IO_RESULT_OK)
> > +     ret =3D avb_ops->write_rollback_index(avb_ops, index, rb_idx);
> > +     if (ret =3D=3D AVB_IO_RESULT_OK)
> >               return CMD_RET_SUCCESS;
> >
> > -     printf("Failed to write rollback index\n");
> > +     printf("Failed to write rollback index id =3D %zu, err =3D %d\n",
> > +            index, ret);
> >
> >       return CMD_RET_FAILURE;
> >  }
> > @@ -203,25 +210,25 @@ int do_avb_get_uuid(struct cmd_tbl *cmdtp, int fl=
ag,
> >  {
> >       const char *part;
> >       char buffer[UUID_STR_LEN + 1];
> > +     int ret;
> >
> > -     if (!avb_ops) {
> > -             printf("AVB 2.0 is not initialized, run 'avb init' first\=
n");
> > -             return CMD_RET_FAILURE;
> > -     }
> > +     AVB_OPS_CHECK(avb_ops);
> >
> >       if (argc !=3D 2)
> >               return CMD_RET_USAGE;
> >
> >       part =3D argv[1];
> >
> > -     if (avb_ops->get_unique_guid_for_partition(avb_ops, part, buffer,
> > -                                                UUID_STR_LEN + 1) =3D=
=3D
> > -                                                AVB_IO_RESULT_OK) {
> > +     ret =3D avb_ops->get_unique_guid_for_partition(avb_ops, part,
> > +                                                  buffer,
> > +                                                  UUID_STR_LEN + 1);
> > +     if (ret =3D=3D AVB_IO_RESULT_OK) {
> >               printf("'%s' UUID: %s\n", part, buffer);
> >               return CMD_RET_SUCCESS;
> >       }
> >
> > -     printf("Failed to read UUID\n");
> > +     printf("Failed to read partition '%s' UUID, err =3D %d\n",
> > +            part, ret);
> >
> >       return CMD_RET_FAILURE;
> >  }
> > @@ -235,14 +242,12 @@ int do_avb_verify_part(struct cmd_tbl *cmdtp, int=
 flag,
> >       char *cmdline;
> >       char *extra_args;
> >       char *slot_suffix =3D "";
> > +     int ret;
> >
> >       bool unlocked =3D false;
> >       int res =3D CMD_RET_FAILURE;
> >
> > -     if (!avb_ops) {
> > -             printf("AVB 2.0 is not initialized, run 'avb init' first\=
n");
> > -             return CMD_RET_FAILURE;
> > -     }
> > +     AVB_OPS_CHECK(avb_ops);
> >
> >       if (argc < 1 || argc > 2)
> >               return CMD_RET_USAGE;
> > @@ -253,9 +258,10 @@ int do_avb_verify_part(struct cmd_tbl *cmdtp, int =
flag,
> >       printf("## Android Verified Boot 2.0 version %s\n",
> >              avb_version_string());
> >
> > -     if (avb_ops->read_is_device_unlocked(avb_ops, &unlocked) !=3D
> > -         AVB_IO_RESULT_OK) {
> > -             printf("Can't determine device lock state.\n");
> > +     ret =3D avb_ops->read_is_device_unlocked(avb_ops, &unlocked);
> > +     if (ret !=3D AVB_IO_RESULT_OK) {
> > +             printf("Can't determine device lock state, err =3D %d\n",
> > +                    ret);
> >               return CMD_RET_FAILURE;
> >       }
> >
> > @@ -302,10 +308,10 @@ int do_avb_verify_part(struct cmd_tbl *cmdtp, int=
 flag,
> >               printf("Corrupted dm-verity metadata detected\n");
> >               break;
> >       case AVB_SLOT_VERIFY_RESULT_ERROR_UNSUPPORTED_VERSION:
> > -             printf("Unsupported version avbtool was used\n");
> > +             printf("Unsupported version of avbtool was used\n");
> >               break;
> >       case AVB_SLOT_VERIFY_RESULT_ERROR_ROLLBACK_INDEX:
> > -             printf("Checking rollback index failed\n");
> > +             printf("Rollback index check failed\n");
> >               break;
> >       case AVB_SLOT_VERIFY_RESULT_ERROR_PUBLIC_KEY_REJECTED:
> >               printf("Public key was rejected\n");
> > @@ -324,24 +330,23 @@ int do_avb_is_unlocked(struct cmd_tbl *cmdtp, int=
 flag,
> >                      int argc, char *const argv[])
> >  {
> >       bool unlock;
> > +     int ret;
> >
> > -     if (!avb_ops) {
> > -             printf("AVB not initialized, run 'avb init' first\n");
> > -             return CMD_RET_FAILURE;
> > -     }
> > +     AVB_OPS_CHECK(avb_ops);
> >
> >       if (argc !=3D 1) {
> >               printf("--%s(-1)\n", __func__);
> >               return CMD_RET_USAGE;
> >       }
> >
> > -     if (avb_ops->read_is_device_unlocked(avb_ops, &unlock) =3D=3D
> > -         AVB_IO_RESULT_OK) {
> > +     ret =3D avb_ops->read_is_device_unlocked(avb_ops, &unlock);
> > +     if (ret =3D=3D AVB_IO_RESULT_OK) {
> >               printf("Unlocked =3D %d\n", unlock);
> >               return CMD_RET_SUCCESS;
> >       }
> >
> > -     printf("Can't determine device lock state.\n");
> > +     printf("Can't determine device lock state, err =3D %d\n",
> > +            ret);
> >
> >       return CMD_RET_FAILURE;
> >  }
> > @@ -354,11 +359,9 @@ int do_avb_read_pvalue(struct cmd_tbl *cmdtp, int =
flag, int argc,
> >       size_t bytes_read;
> >       void *buffer;
> >       char *endp;
> > +     int ret;
> >
> > -     if (!avb_ops) {
> > -             printf("AVB 2.0 is not initialized, run 'avb init' first\=
n");
> > -             return CMD_RET_FAILURE;
> > -     }
> > +     AVB_OPS_CHECK(avb_ops);
> >
> >       if (argc !=3D 3)
> >               return CMD_RET_USAGE;
> > @@ -372,15 +375,16 @@ int do_avb_read_pvalue(struct cmd_tbl *cmdtp, int=
 flag, int argc,
> >       if (!buffer)
> >               return CMD_RET_FAILURE;
> >
> > -     if (avb_ops->read_persistent_value(avb_ops, name, bytes, buffer,
> > -                                        &bytes_read) =3D=3D AVB_IO_RES=
ULT_OK) {
> > +     ret =3D avb_ops->read_persistent_value(avb_ops, name, bytes,
> > +                                          buffer, &bytes_read);
> > +     if (ret =3D=3D AVB_IO_RESULT_OK) {
> >               printf("Read %zu bytes, value =3D %s\n", bytes_read,
> >                      (char *)buffer);
> >               free(buffer);
> >               return CMD_RET_SUCCESS;
> >       }
> >
> > -     printf("Failed to read persistent value\n");
> > +     printf("Failed to read persistent value, err =3D %d\n", ret);
> >
> >       free(buffer);
> >
> > @@ -392,11 +396,9 @@ int do_avb_write_pvalue(struct cmd_tbl *cmdtp, int=
 flag, int argc,
> >  {
> >       const char *name;
> >       const char *value;
> > +     int ret;
> >
> > -     if (!avb_ops) {
> > -             printf("AVB 2.0 is not initialized, run 'avb init' first\=
n");
> > -             return CMD_RET_FAILURE;
> > -     }
> > +     AVB_OPS_CHECK(avb_ops);
> >
> >       if (argc !=3D 3)
> >               return CMD_RET_USAGE;
> > @@ -404,14 +406,16 @@ int do_avb_write_pvalue(struct cmd_tbl *cmdtp, in=
t flag, int argc,
> >       name =3D argv[1];
> >       value =3D argv[2];
> >
> > -     if (avb_ops->write_persistent_value(avb_ops, name, strlen(value) =
+ 1,
> > -                                         (const uint8_t *)value) =3D=
=3D
> > -         AVB_IO_RESULT_OK) {
> > +     ret =3D avb_ops->write_persistent_value(avb_ops, name,
> > +                                           strlen(value) + 1,
> > +                                           (const uint8_t *)value);
> > +     if (ret =3D=3D AVB_IO_RESULT_OK) {
> >               printf("Wrote %zu bytes\n", strlen(value) + 1);
> >               return CMD_RET_SUCCESS;
> >       }
> >
> > -     printf("Failed to write persistent value\n");
> > +     printf("Failed to write persistent value `%s` =3D `%s`, err =3D %=
d\n",
> > +            name, value, ret);
> >
> >       return CMD_RET_FAILURE;
> >  }
> > --
> > 2.34.1



--=20
Best regards - Freundliche Gr=C3=BCsse - Meilleures salutations

Igor Opaniuk
Senior Software Engineer, Embedded & Security
E: igor.opaniuk@foundries.io
W: www.foundries.io
