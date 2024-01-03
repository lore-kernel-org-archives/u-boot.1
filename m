Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C5A0C3DA6E
	for <u-boot@archiver.kernel.org>; Wed,  3 Jan 2024 08:25:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 796FA87787;
	Wed,  3 Jan 2024 09:25:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="nDO7ueKi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ABC6487745; Wed,  3 Jan 2024 09:25:08 +0100 (CET)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5681D879BB
 for <u-boot@lists.denx.de>; Wed,  3 Jan 2024 09:25:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael@amarulasolutions.com
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-5569472f775so1498723a12.2
 for <u-boot@lists.denx.de>; Wed, 03 Jan 2024 00:25:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1704270301; x=1704875101;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PdZ4e23+MAjwdg8upm0boVPGU0zNETUGHj7Q3qXfkDY=;
 b=nDO7ueKiLMGFBnAA3mAGiH8vLzbkL0+x8CGS6PZj8OLUZvFiB8omAdZPqUWt5Bz+GV
 e6r+MJ3p79OvCwQmRHrEe2FSSBTodig4857avRpkmg4gSPPy339n3U3SWW6mO55VBliz
 Y5dMXTAd125leKEvlajTTpDnCMbXfJquszF84=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704270301; x=1704875101;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PdZ4e23+MAjwdg8upm0boVPGU0zNETUGHj7Q3qXfkDY=;
 b=jYfwAiRTtMJIO/SXIQSBjhAgDsBYxVxa6MmSQ30rfw818yLIQ1/XyCtoKeiYoIJcVz
 idadO4zPYPkdgpfoADoyfY106iH9IXoXXp9VPsIX39DAmWTnzECBVUq4c8XtwFT94EjW
 GrtwZtnsMKF88WyZbrkzf2ettje3VdCZ2RIXFcWF33oLERLqxpZ/yY8dmhDnNKeE9eUo
 AqM3c2OIQQUtNKjuO56rDLBiACmxSFEHmQ5X3PcX/cxA9b4OhH8oPpK2Iue4+IYV4cG+
 TuaA4MoPz7o9DF6BEL8A6Ac8dMUGsdL3awH+8o8k4lRGS3ovtdCbxQBO7B3rlJOFaC1E
 h42Q==
X-Gm-Message-State: AOJu0YztzrPPDaNvSn+4/iNNXm/5yuiJ4lvA9jNjQK29lNRzTuHXXjgk
 qhLvT3G/MM0uUG9gouaaesj9KmP3HTEDUM19mZiIaB4nYQZALg==
X-Google-Smtp-Source: AGHT+IGeDbRZDC7RT4QbDLszwAAQuN43uR9+Dp7PSkhsJrXemyabO7nOLWogo7Y0krMGl54Gdf9R6T9/zUM4fFELrU0=
X-Received: by 2002:a17:906:c35a:b0:a26:85ed:78dc with SMTP id
 ci26-20020a170906c35a00b00a2685ed78dcmr8257242ejb.133.1704270300943; Wed, 03
 Jan 2024 00:25:00 -0800 (PST)
MIME-Version: 1.0
References: <20231228153922.84323-1-avromanov@salutedevices.com>
 <20231228153922.84323-8-avromanov@salutedevices.com>
In-Reply-To: <20231228153922.84323-8-avromanov@salutedevices.com>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Wed, 3 Jan 2024 09:24:49 +0100
Message-ID: <CAOf5uw=hdzOjja5ZwK0X_5K5YyFpfvSViE2b33QDQWcdDKu7hA@mail.gmail.com>
Subject: Re: [PATCH v1 07/12] mtdparts: use negative error codes
To: Alexey Romanov <avromanov@salutedevices.com>
Cc: michal.simek@amd.com, marex@denx.de, michael@walle.cc, 
 stcarlso@linux.microsoft.com, tobias@waldekranz.com, seanedmond@microsoft.com, 
 abdellatif.elkhlifi@arm.com, neil.armstrong@linaro.org, n-jain1@ti.com, 
 xypron.glpk@gmx.de, dario.binacchi@amarulasolutions.com, 
 frieder.schrempf@kontron.de, sjg@chromium.org, hs@denx.de, 
 sean.anderson@seco.com, dimorinny@google.com, mkorpershoek@baylibre.com, 
 patrick.delaunay@foss.st.com, u-boot@lists.denx.de, kernel@salutedevices.com
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

Hi

On Thu, Dec 28, 2023 at 4:39=E2=80=AFPM Alexey Romanov
<avromanov@salutedevices.com> wrote:
>
> It is bad practice to use such error codes. Error codes
> must be negative.
>
> Also, fastboot code expects that if successful, mtdparts
> functions will return a value greater than 0. You can see
> fastboot_nand_get_part_info() functions calls inside
> getvar_get_part_info().
>
> And use 'return CMD_RET_FAILURE' define instead of 'return 1'.
>

Can you split the CMD_RET_FAILURE in a separate patch?

> Signed-off-by: Alexey Romanov <avromanov@salutedevices.com>
> ---
>  cmd/mtdparts.c | 154 ++++++++++++++++++++++++-------------------------
>  1 file changed, 77 insertions(+), 77 deletions(-)
>
> diff --git a/cmd/mtdparts.c b/cmd/mtdparts.c
> index 0984158f41..08e5b794db 100644
> --- a/cmd/mtdparts.c
> +++ b/cmd/mtdparts.c
> @@ -299,7 +299,7 @@ static void current_save(void)
>   * @param type mtd type
>   * @param num mtd number
>   * @param mtd a pointer to an mtd_info instance (output)
> - * Return: 0 if device is valid, 1 otherwise
> + * Return: 0 if device is valid, -errno otherwise
>   */
>  static int get_mtd_info(u8 type, u8 num, struct mtd_info **mtd)
>  {
> @@ -309,7 +309,7 @@ static int get_mtd_info(u8 type, u8 num, struct mtd_i=
nfo **mtd)
>         *mtd =3D get_mtd_device_nm(mtd_dev);
>         if (IS_ERR(*mtd)) {
>                 printf("Device %s not found!\n", mtd_dev);
> -               return 1;
> +               return -ENODEV;
>         }
>         put_mtd_device(*mtd);
>
> @@ -323,7 +323,7 @@ static int get_mtd_info(u8 type, u8 num, struct mtd_i=
nfo **mtd)
>   *
>   * @param id of the parent device
>   * @param part partition to validate
> - * Return: 0 if partition is valid, 1 otherwise
> + * Return: 0 if partition is valid, -errno otherwise
>   */
>  static int part_validate_eraseblock(struct mtdids *id, struct part_info =
*part)
>  {
> @@ -333,7 +333,7 @@ static int part_validate_eraseblock(struct mtdids *id=
, struct part_info *part)
>         u64 offset, size;
>
>         if (get_mtd_info(id->type, id->num, &mtd))
> -               return 1;
> +               return -EINVAL;
>
>         part->sector_size =3D mtd->erasesize;
>
> @@ -347,14 +347,14 @@ static int part_validate_eraseblock(struct mtdids *=
id, struct part_info *part)
>                         printf("%s%d: partition (%s) start offset"
>                                "alignment incorrect\n",
>                                MTD_DEV_TYPE(id->type), id->num, part->nam=
e);
> -                       return 1;
> +                       return -EINVAL;
>                 }
>
>                 size =3D part->size;
>                 if (do_div(size, mtd->erasesize)) {
>                         printf("%s%d: partition (%s) size alignment incor=
rect\n",
>                                MTD_DEV_TYPE(id->type), id->num, part->nam=
e);
> -                       return 1;
> +                       return -EINVAL;
>                 }
>         } else {
>                 /*
> @@ -374,7 +374,7 @@ static int part_validate_eraseblock(struct mtdids *id=
, struct part_info *part)
>
>                 printf("%s%d: partition (%s) start offset alignment incor=
rect\n",
>                        MTD_DEV_TYPE(id->type), id->num, part->name);
> -               return 1;
> +               return -EINVAL;
>
>         start_ok:
>
> @@ -393,7 +393,7 @@ static int part_validate_eraseblock(struct mtdids *id=
, struct part_info *part)
>
>                 printf("%s%d: partition (%s) size alignment incorrect\n",
>                        MTD_DEV_TYPE(id->type), id->num, part->name);
> -               return 1;
> +               return -EINVAL;
>
>         end_ok:
>                 return 0;
> @@ -410,7 +410,7 @@ static int part_validate_eraseblock(struct mtdids *id=
, struct part_info *part)
>   *
>   * @param id of the parent device
>   * @param part partition to validate
> - * Return: 0 if partition is valid, 1 otherwise
> + * Return: 0 if partition is valid, -errno otherwise
>   */
>  static int part_validate(struct mtdids *id, struct part_info *part)
>  {
> @@ -420,18 +420,18 @@ static int part_validate(struct mtdids *id, struct =
part_info *part)
>         if (part->offset > id->size) {
>                 printf("%s: offset %08llx beyond flash size %08llx\n",
>                                 id->mtd_id, part->offset, id->size);
> -               return 1;
> +               return -EINVAL;
>         }
>
>         if ((part->offset + part->size) <=3D part->offset) {
>                 printf("%s%d: partition (%s) size too big\n",
>                                 MTD_DEV_TYPE(id->type), id->num, part->na=
me);
> -               return 1;
> +               return -EINVAL;
>         }
>
>         if (part->offset + part->size > id->size) {
>                 printf("%s: partitioning exceeds flash size\n", id->mtd_i=
d);
> -               return 1;
> +               return -EINVAL;
>         }
>
>         /*
> @@ -446,7 +446,7 @@ static int part_validate(struct mtdids *id, struct pa=
rt_info *part)
>   *
>   * @param dev device to delete partition from
>   * @param part partition to delete
> - * Return: 0 on success, 1 otherwise
> + * Return: 0 on success, -ernno otherwise
>   */
>  static int part_del(struct mtd_device *dev, struct part_info *part)
>  {
> @@ -544,7 +544,7 @@ static int part_sort_add(struct mtd_device *dev, stru=
ct part_info *part)
>                 /* be compliant with kernel cmdline, allow only one parti=
tion at offset zero */
>                 if ((new_pi->offset =3D=3D pi->offset) && (pi->offset =3D=
=3D 0)) {
>                         printf("cannot add second partition at offset 0\n=
");
> -                       return 1;
> +                       return -EINVAL;
>                 }
>
>                 if (new_pi->offset <=3D pi->offset) {
> @@ -574,17 +574,17 @@ static int part_sort_add(struct mtd_device *dev, st=
ruct part_info *part)
>   *
>   * @param dev device to which partition is added
>   * @param part partition to be added
> - * Return: 0 on success, 1 otherwise
> + * Return: 0 on success, -errno otherwise
>   */
>  static int part_add(struct mtd_device *dev, struct part_info *part)
>  {
>         /* verify alignment and size */
>         if (part_validate(dev->id, part) !=3D 0)
> -               return 1;
> +               return -EINVAL;
>
>         /* partition is ok, add it to the list */
>         if (part_sort_add(dev, part) !=3D 0)
> -               return 1;
> +               return -EINVAL;
>
>         return 0;
>  }
> @@ -596,7 +596,7 @@ static int part_add(struct mtd_device *dev, struct pa=
rt_info *part)
>   * @param partdef pointer to the partition definition string i.e. <part-=
def>
>   * @param ret output pointer to next char after parse completes (output)
>   * @param retpart pointer to the allocated partition (output)
> - * Return: 0 on success, 1 otherwise
> + * Return: 0 on success, -errno otherwise
>   */
>  static int part_parse(const char *const partdef, const char **ret, struc=
t part_info **retpart)
>  {
> @@ -622,7 +622,7 @@ static int part_parse(const char *const partdef, cons=
t char **ret, struct part_i
>                 size =3D memsize_parse(p, &p);
>                 if (size < MIN_PART_SIZE) {
>                         printf("partition size too small (%llx)\n", size)=
;
> -                       return 1;
> +                       return -EINVAL;
>                 }
>         }
>
> @@ -638,12 +638,12 @@ static int part_parse(const char *const partdef, co=
nst char **ret, struct part_i
>                 name =3D ++p;
>                 if ((p =3D strchr(name, ')')) =3D=3D NULL) {
>                         printf("no closing ) found in partition name\n");
> -                       return 1;
> +                       return -EINVAL;
>                 }
>                 name_len =3D p - name + 1;
>                 if ((name_len - 1) =3D=3D 0) {
>                         printf("empty partition name\n");
> -                       return 1;
> +                       return -EINVAL;
>                 }
>                 p++;
>         } else {
> @@ -664,7 +664,7 @@ static int part_parse(const char *const partdef, cons=
t char **ret, struct part_i
>                 if (size =3D=3D SIZE_REMAINING) {
>                         *ret =3D NULL;
>                         printf("no partitions allowed after a fill-up par=
tition\n");
> -                       return 1;
> +                       return -EINVAL;
>                 }
>                 *ret =3D ++p;
>         } else if ((*p =3D=3D ';') || (*p =3D=3D '\0')) {
> @@ -672,14 +672,14 @@ static int part_parse(const char *const partdef, co=
nst char **ret, struct part_i
>         } else {
>                 printf("unexpected character '%c' at the end of partition=
\n", *p);
>                 *ret =3D NULL;
> -               return 1;
> +               return -EINVAL;
>         }
>
>         /*  allocate memory */
>         part =3D (struct part_info *)malloc(sizeof(struct part_info) + na=
me_len);
>         if (!part) {
>                 printf("out of memory\n");
> -               return 1;
> +               return -ENOMEM;
>         }
>         memset(part, 0, sizeof(struct part_info) + name_len);
>         part->size =3D size;
> @@ -714,14 +714,14 @@ static int part_parse(const char *const partdef, co=
nst char **ret, struct part_i
>   * @param type mtd type
>   * @param num mtd number
>   * @param size a pointer to the size of the mtd device (output)
> - * Return: 0 if device is valid, 1 otherwise
> + * Return: 0 if device is valid, -errno otherwise
>   */
>  static int mtd_device_validate(u8 type, u8 num, u64 *size)
>  {
>         struct mtd_info *mtd =3D NULL;
>
>         if (get_mtd_info(type, num, &mtd))
> -               return 1;
> +               return -EINVAL;
>
>         *size =3D mtd->size;
>
> @@ -732,7 +732,7 @@ static int mtd_device_validate(u8 type, u8 num, u64 *=
size)
>   * Delete all mtd devices from a supplied devices list, free memory allo=
cated for
>   * each device and delete all device partitions.
>   *
> - * Return: 0 on success, 1 otherwise
> + * Return: 0 on success, -errno otherwise
>   */
>  static int device_delall(struct list_head *head)
>  {
> @@ -756,7 +756,7 @@ static int device_delall(struct list_head *head)
>   * from device list and device memory is freed.
>   *
>   * @param dev device to be deleted
> - * Return: 0 on success, 1 otherwise
> + * Return: 0 on success, -errno otherwise
>   */
>  static int device_del(struct mtd_device *dev)
>  {
> @@ -835,7 +835,7 @@ static void device_add(struct mtd_device *dev)
>   * @param mtd_dev pointer to the device definition string i.e. <mtd-dev>
>   * @param ret output pointer to next char after parse completes (output)
>   * @param retdev pointer to the allocated device (output)
> - * Return: 0 on success, 1 otherwise
> + * Return: 0 on success, -errno otherwise
>   */
>  static int device_parse(const char *const mtd_dev, const char **ret, str=
uct mtd_device **retdev)
>  {
> @@ -864,7 +864,7 @@ static int device_parse(const char *const mtd_dev, co=
nst char **ret, struct mtd_
>         mtd_id =3D p =3D mtd_dev;
>         if (!(p =3D strchr(mtd_id, ':'))) {
>                 printf("no <mtd-id> identifier\n");
> -               return 1;
> +               return -EINVAL;
>         }
>         mtd_id_len =3D p - mtd_id + 1;
>         p++;
> @@ -872,7 +872,7 @@ static int device_parse(const char *const mtd_dev, co=
nst char **ret, struct mtd_
>         /* verify if we have a valid device specified */
>         if ((id =3D id_find_by_mtd_id(mtd_id, mtd_id_len - 1)) =3D=3D NUL=
L) {
>                 printf("invalid mtd device '%.*s'\n", mtd_id_len - 1, mtd=
_id);
> -               return 1;
> +               return -ENODEV;
>         }
>
>         pend =3D strchr(p, ';');
> @@ -915,7 +915,7 @@ static int device_parse(const char *const mtd_dev, co=
nst char **ret, struct mtd_
>         }
>         if (err =3D=3D 1) {
>                 part_delall(&tmp_list);
> -               return 1;
> +               return -EINVAL;
>         }
>
>         debug("\ntotal partitions: %d\n", num_parts);
> @@ -932,14 +932,14 @@ static int device_parse(const char *const mtd_dev, =
const char **ret, struct mtd_
>                         printf("unexpected character '%c' at the end of d=
evice\n", *p);
>                         if (ret)
>                                 *ret =3D NULL;
> -                       return 1;
> +                       return -EINVAL;
>                 }
>         }
>
>         /* allocate memory for mtd_device structure */
>         if ((dev =3D (struct mtd_device *)malloc(sizeof(struct mtd_device=
))) =3D=3D NULL) {
>                 printf("out of memory\n");
> -               return 1;
> +               return -ENOMEM;
>         }
>         memset(dev, 0, sizeof(struct mtd_device));
>         dev->id =3D id;
> @@ -953,7 +953,7 @@ static int device_parse(const char *const mtd_dev, co=
nst char **ret, struct mtd_
>                 list_del(entry);
>                 if (part_sort_add(dev, part) !=3D 0) {
>                         device_del(dev);
> -                       return 1;
> +                       return -EINVAL;
>                 }
>         }
>
> @@ -966,7 +966,7 @@ static int device_parse(const char *const mtd_dev, co=
nst char **ret, struct mtd_
>  /**
>   * Initialize global device list.
>   *
> - * Return: 0 on success, 1 otherwise
> + * Return: 0 on success, -errno otherwise
>   */
>  static int mtd_devices_init(void)
>  {
> @@ -1037,7 +1037,7 @@ static struct mtdids* id_find_by_mtd_id(const char =
*mtd_id, unsigned int mtd_id_
>   * @param ret_id output pointer to next char after parse completes (outp=
ut)
>   * @param dev_type parsed device type (output)
>   * @param dev_num parsed device number (output)
> - * Return: 0 on success, 1 otherwise
> + * Return: 0 on success, -errno otherwise
>   */
>  int mtd_id_parse(const char *id, const char **ret_id, u8 *dev_type,
>                  u8 *dev_num)
> @@ -1059,12 +1059,12 @@ int mtd_id_parse(const char *id, const char **ret=
_id, u8 *dev_type,
>                 p +=3D 8;
>         } else {
>                 printf("incorrect device type in %s\n", id);
> -               return 1;
> +               return -EINVAL;
>         }
>
>         if (!isdigit(*p)) {
>                 printf("incorrect device number in %s\n", id);
> -               return 1;
> +               return -EINVAL;
>         }
>
>         *dev_num =3D simple_strtoul(p, (char **)&p, 0);
> @@ -1079,7 +1079,7 @@ int mtd_id_parse(const char *id, const char **ret_i=
d, u8 *dev_type,
>   *
>   * @param buf output buffer holding generated mtdparts string (output)
>   * @param buflen buffer size
> - * Return: 0 on success, 1 otherwise
> + * Return: 0 on success, -errno otherwise
>   */
>  static int generate_mtdparts(char *buf, u32 buflen)
>  {
> @@ -1195,7 +1195,7 @@ static int generate_mtdparts(char *buf, u32 buflen)
>
>  cleanup:
>         last_parts[0] =3D '\0';
> -       return 1;
> +       return -EINVAL;
>  }
>
>  /**
> @@ -1204,7 +1204,7 @@ cleanup:
>   *
>   * @param buf output buffer holding generated mtdparts string (output)
>   * @param buflen buffer size
> - * Return: 0 on success, 1 otherwise
> + * Return: 0 on success, -errno otherwise
>   */
>  static int generate_mtdparts_save(char *buf, u32 buflen)
>  {
> @@ -1342,7 +1342,7 @@ static void list_partitions(void)
>   * @param dev pointer to the requested device (output)
>   * @param part_num verified partition number (output)
>   * @param part pointer to requested partition (output)
> - * Return: 0 on success, 1 otherwise
> + * Return: 0 on success, -errno otherwise
>   */
>  int find_dev_and_part(const char *id, struct mtd_device **dev,
>                 u8 *part_num, struct part_info **part)
> @@ -1370,27 +1370,27 @@ int find_dev_and_part(const char *id, struct mtd_=
device **dev,
>         *part_num =3D 0;
>
>         if (mtd_id_parse(p, &p, &type, &dnum) !=3D 0)
> -               return 1;
> +               return -EINVAL;
>
>         if ((*p++ !=3D ',') || (*p =3D=3D '\0')) {
>                 printf("no partition number specified\n");
> -               return 1;
> +               return -EINVAL;
>         }
>         pnum =3D simple_strtoul(p, (char **)&p, 0);
>         if (*p !=3D '\0') {
>                 printf("unexpected trailing character '%c'\n", *p);
> -               return 1;
> +               return -EINVAL;
>         }
>
>         if ((*dev =3D device_find(type, dnum)) =3D=3D NULL) {
>                 printf("no such device %s%d\n", MTD_DEV_TYPE(type), dnum)=
;
> -               return 1;
> +               return -ENODEV;
>         }
>
>         if ((*part =3D mtd_part_info(*dev, pnum)) =3D=3D NULL) {
>                 printf("no such partition\n");
>                 *dev =3D NULL;
> -               return 1;
> +               return -EINVAL;
>         }
>
>         *part_num =3D pnum;
> @@ -1402,7 +1402,7 @@ int find_dev_and_part(const char *id, struct mtd_de=
vice **dev,
>   * Find and delete partition. For partition id format see find_dev_and_p=
art().
>   *
>   * @param id string describing device and partition
> - * Return: 0 on success, 1 otherwise
> + * Return: 0 on success, -errno otherwise
>   */
>  static int delete_partition(const char *id)
>  {
> @@ -1417,17 +1417,17 @@ static int delete_partition(const char *id)
>                                 part->name, part->size, part->offset);
>
>                 if (part_del(dev, part) !=3D 0)
> -                       return 1;
> +                       return -EINVAL;
>
>                 if (generate_mtdparts_save(last_parts, MTDPARTS_MAXLEN) !=
=3D 0) {
>                         printf("generated mtdparts too long, resetting to=
 null\n");
> -                       return 1;
> +                       return -EINVAL;
>                 }
>                 return 0;
>         }
>
>         printf("partition %s not found\n", id);
> -       return 1;
> +       return -ENOENT;
>  }
>
>  #if defined(CONFIG_CMD_MTDPARTS_SPREAD)
> @@ -1478,7 +1478,7 @@ static void spread_partition(struct mtd_info *mtd, =
struct part_info *part,
>   * as big as their mtdparts environment variable sizes and they each sta=
rt
>   * on a good block.
>   *
> - * Return: 0 on success, 1 otherwise
> + * Return: 0 on success, -errno otherwise
>   */
>  static int spread_partitions(void)
>  {
> @@ -1493,7 +1493,7 @@ static int spread_partitions(void)
>                 dev =3D list_entry(dentry, struct mtd_device, link);
>
>                 if (get_mtd_info(dev->id->type, dev->id->num, &mtd))
> -                       return 1;
> +                       return -EINVAL;
>
>                 part_num =3D 0;
>                 cur_offs =3D 0;
> @@ -1519,7 +1519,7 @@ static int spread_partitions(void)
>
>         if (generate_mtdparts_save(last_parts, MTDPARTS_MAXLEN) !=3D 0) {
>                 printf("generated mtdparts too long, resetting to null\n"=
);
> -               return 1;
> +               return -EINVAL;
>         }
>         return 0;
>  }
> @@ -1547,7 +1547,7 @@ static const char *env_get_mtdparts(char *buf)
>   * for each entry. Add created devices to the global devices list.
>   *
>   * @param mtdparts string specifing mtd partitions
> - * Return: 0 on success, 1 otherwise
> + * Return: 0 on success, -errno otherwise
>   */
>  static int parse_mtdparts(const char *const mtdparts)
>  {
> @@ -1605,7 +1605,7 @@ static int parse_mtdparts(const char *const mtdpart=
s)
>   * to the global mtdids list.
>   *
>   * @param ids mapping string
> - * Return: 0 on success, 1 otherwise
> + * Return: 0 on success, -errno otherwise
>   */
>  static int parse_mtdids(const char *const ids)
>  {
> @@ -1646,7 +1646,7 @@ static int parse_mtdids(const char *const ids)
>
>                 /* check if requested device exists */
>                 if (mtd_device_validate(type, num, &size) !=3D 0)
> -                       return 1;
> +                       return -EINVAL;
>
>                 /* locate <mtd-id> */
>                 mtd_id =3D p;
> @@ -1704,7 +1704,7 @@ static int parse_mtdids(const char *const ids)
>                         list_del(entry);
>                         free(id_tmp);
>                 }
> -               return 1;
> +               return -EINVAL;
>         }
>
>         return 0;
> @@ -1715,7 +1715,7 @@ static int parse_mtdids(const char *const ids)
>   * Parse and initialize global mtdids mapping and create global
>   * device/partition list.
>   *
> - * Return: 0 on success, 1 otherwise
> + * Return: 0 on success, -errno otherwise
>   */
>  int mtdparts_init(void)
>  {
> @@ -1768,12 +1768,12 @@ int mtdparts_init(void)
>                         env_set("mtdids", (char *)ids);
>                 } else {
>                         printf("mtdids not defined, no default present\n"=
);
> -                       return 1;
> +                       return -ENXIO;
>                 }
>         }
>         if (strlen(ids) > MTDIDS_MAXLEN - 1) {
>                 printf("mtdids too long (> %d)\n", MTDIDS_MAXLEN);
> -               return 1;
> +               return -EINVAL;
>         }
>
>         /* use defaults when mtdparts variable is not defined
> @@ -1789,7 +1789,7 @@ int mtdparts_init(void)
>
>         if (parts && (strlen(parts) > MTDPARTS_MAXLEN - 1)) {
>                 printf("mtdparts too long (> %d)\n", MTDPARTS_MAXLEN);
> -               return 1;
> +               return -EINVAL;
>         }
>
>         /* check if we have already parsed those mtdids */
> @@ -1800,7 +1800,7 @@ int mtdparts_init(void)
>
>                 if (parse_mtdids(ids) !=3D 0) {
>                         mtd_devices_init();
> -                       return 1;
> +                       return -EINVAL;
>                 }
>
>                 /* ok it's good, save new ids */
> @@ -1810,11 +1810,11 @@ int mtdparts_init(void)
>         /* parse partitions if either mtdparts or mtdids were updated */
>         if (parts && ((last_parts[0] =3D=3D '\0') || ((strcmp(last_parts,=
 parts) !=3D 0)) || ids_changed)) {
>                 if (parse_mtdparts(parts) !=3D 0)
> -                       return 1;
> +                       return -EINVAL;
>
>                 if (list_empty(&devices)) {
>                         printf("mtdparts_init: no valid partitions\n");
> -                       return 1;
> +                       return -ENXIO;
>                 }
>
>                 /* ok it's good, save new parts */
> @@ -1923,15 +1923,15 @@ static int do_chpart(struct cmd_tbl *cmdtp, int f=
lag, int argc,
>         u8 pnum;
>
>         if (mtdparts_init() !=3D0)
> -               return 1;
> +               return CMD_RET_FAILURE;
>
>         if (argc < 2) {
>                 printf("no partition id specified\n");
> -               return 1;
> +               return CMD_RET_FAILURE;
>         }
>
>         if (find_dev_and_part(argv[1], &dev, &pnum, &part) !=3D 0)
> -               return 1;
> +               return CMD_RET_FAILURE;
>
>         current_mtd_dev =3D dev;
>         current_mtd_partnum =3D pnum;
> @@ -1978,7 +1978,7 @@ static int do_mtdparts(struct cmd_tbl *cmdtp, int f=
lag, int argc,
>
>         /* make sure we are in sync with env variables */
>         if (mtdparts_init() !=3D 0)
> -               return 1;
> +               return CMD_RET_FAILURE;
>
>         if (argc =3D=3D 1) {
>                 list_partitions();
> @@ -2000,11 +2000,11 @@ static int do_mtdparts(struct cmd_tbl *cmdtp, int=
 flag, int argc,
>                 struct part_info *p;
>
>                 if (mtd_id_parse(argv[2], NULL, &type, &num) !=3D 0)
> -                       return 1;
> +                       return CMD_RET_FAILURE;
>
>                 if ((id =3D id_find(type, num)) =3D=3D NULL) {
>                         printf("no such device %s defined in mtdids varia=
ble\n", argv[2]);
> -                       return 1;
> +                       return CMD_RET_FAILURE;
>                 }
>
>                 len =3D strlen(id->mtd_id) + 1;   /* 'mtd_id:' */
> @@ -2015,14 +2015,14 @@ static int do_mtdparts(struct cmd_tbl *cmdtp, int=
 flag, int argc,
>
>                 if (len >=3D PART_ADD_DESC_MAXLEN) {
>                         printf("too long partition description\n");
> -                       return 1;
> +                       return CMD_RET_FAILURE;
>                 }
>                 sprintf(tmpbuf, "%s:%s(%s)%s",
>                                 id->mtd_id, argv[3], argv[4], argv[5] ? a=
rgv[5] : "");
>                 debug("add tmpbuf: %s\n", tmpbuf);
>
>                 if ((device_parse(tmpbuf, NULL, &dev) !=3D 0) || (!dev))
> -                       return 1;
> +                       return -EINVAL;
>
>                 debug("+ %s\t%d\t%s\n", MTD_DEV_TYPE(dev->id->type),
>                                 dev->id->num, dev->id->mtd_id);
> @@ -2031,7 +2031,7 @@ static int do_mtdparts(struct cmd_tbl *cmdtp, int f=
lag, int argc,
>
>  #if defined(CONFIG_CMD_MTDPARTS_SPREAD)
>                 if (get_mtd_info(dev->id->type, dev->id->num, &mtd))
> -                       return 1;
> +                       return CMD_RET_FAILURE;
>
>                 if (!strcmp(&argv[1][3], ".spread")) {
>                         spread_partition(mtd, p, &next_offset);
> @@ -2045,12 +2045,12 @@ static int do_mtdparts(struct cmd_tbl *cmdtp, int=
 flag, int argc,
>                 } else if (part_add(dev_tmp, p) !=3D 0) {
>                         /* merge new partition with existing ones*/
>                         device_del(dev);
> -                       return 1;
> +                       return CMD_RET_FAILURE;
>                 }
>
>                 if (generate_mtdparts_save(last_parts, MTDPARTS_MAXLEN) !=
=3D 0) {
>                         printf("generated mtdparts too long, resetting to=
 null\n");
> -                       return 1;
> +                       return CMD_RET_FAILURE;
>                 }
>
>                 return 0;
> --
> 2.30.1
>

Reviewed-by: Michael Trimarchi <michael@amarulasolutions.com>
