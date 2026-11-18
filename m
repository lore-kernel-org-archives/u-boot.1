Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D584606A31C
	for <u-boot@archiver.kernel.org>; Wed, 18 Nov 2026 10:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=gSQ95eHP;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=j9HyIXbq
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3E411608CB;
	Wed, 18 Nov 2026 10:08:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JcE-dGnPTQWt; Wed, 18 Nov 2026 10:08:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 2DD0560853
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794996527;
	b=QaKMqUpUKRrN8W8GbLOnlyAMPPVDZccb5Gg69v4fm8QrDDCPG6xja4kzRaokAaSeN402
	 UrsuHfamecU/aQIohYUXSye5mMVhd++dYQisfb8MmcKK8ueAzj2B27EYsNCllkAjWqUY1
	 Gt+XLdnQWvvGrbvqRab3Ov0JajPjCAJlpSgDvnEhmfQlRhvPAS9NW71Xs7jylKFUFVpZY
	 UbRSfooMV+Vup8lFzrYnwkN6KMrG8LhxyEY7NyQvzedEiTDPSUCol2juFJ076l0XS+bGZ
	 Wp7QuYS51TXeY44ey0+E8DQ6tWF1YmYVpQ+cB0DrzDLWbZiEjo0IRSaxh/zQAcu04ig==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794996527;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Comment:Received:Received:
	 Received:Received:Received:DKIM-Signature:From:To:Cc:Subject:
	 In-Reply-To:References:Date:Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Virus-Scanned:X-Virus-Status:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=Ke3hYJ0XZaxG1YP90M33ERmw4U1RNYucXLjtDouZnA8=;
	b=FiZBGCE28JsCD6+Lbpea3pDHb5WPxfiCGCshKFLPJWMgMDhPAok6R4i/9QgDElu3bo76
	 I4gKeEgYXtOpyyBKgC9xo3gSQlPdAQTBdQ7zSRsB+7XWFk9l8a3U/GNoKkA7dV3lyuitg
	 coybg0RDqWFjwBlEXEOSYrcJUebeXwfvcIxt0T74Wv5M92RJbanTer2CqNAKhCKBUbXxJ
	 pwAyHZZunXjxcVduvfvX2+UMAc254FTx++NW3oWs8ZkSY9/hteBNH5N5owwGOpmsQD82w
	 FSWC4ctbx8M3Fwoh7x6KSOZopdN2CbL95A2H14UBRbidrqj+y/+hWW9j45yABkR6LVw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794996527;
	bh=Ke3hYJ0XZaxG1YP90M33ERmw4U1RNYucXLjtDouZnA8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=gSQ95eHPt5F8E4RMOuc2UyvhQoQrpteuPAg5SL7GaRVhD2tinR1bZGD5Ga/AyE+dc
	 XDzekboUBE0jIpC8cZ0aV2BKSDXICnrKu7pM3BZr6smSkAdLLoXU9NXTv/fGbYBmxw
	 KnBWfW8AJbY6NWg/bojfQtOZGnLIkMGXNDoPxaRgRKcfU7kLqfpEwoaJoVOEDA9co0
	 6AXIozWXQ9uE/lXpfPDSpS2SjE0vGOoHDUj9zv8xq/vULjLj5+lAsBon5pMj6WjNHZ
	 HKolNP6BeIWZO3A9220nNm+VxgMDpf8GAe/xME453ef1ElK9ot7cvw5MjUDPnHF3s3
	 OpSz16DNly03A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2DD0560853;
	Wed, 18 Nov 2026 10:08:47 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id F30A3A0E
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 10:08:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D8BEB400CD
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 10:08:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id n3itRvw-Jrwp for <u-boot@lists.u-boot-project.org>;
 Wed, 18 Nov 2026 10:08:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 3E6C240060
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=85.214.62.61
X-Comment: SPF check N/A for local connections - client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=mkorpershoek@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp2.osuosl.org; spf=fail smtp.mailfrom=kernel.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=j9HyIXbq
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 3E6C240060
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 10:08:41 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4E12C84813; Wed, 18 Nov 2026 11:08:39 +0100 (CET)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AF4D7847EB
 for <u-boot@lists.denx.de>; Wed, 18 Nov 2026 11:08:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 618E1620A7;
 Wed, 18 Nov 2026 10:08:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 956FB1F000C8;
 Wed, 18 Nov 2026 10:08:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794996510;
 bh=Ke3hYJ0XZaxG1YP90M33ERmw4U1RNYucXLjtDouZnA8=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date;
 b=j9HyIXbq5OLgb05f9vnRdnCrPNWeD0yKXc+yvLJEuTagxZ12To/jaflFBPAZiCAeK
 +If3pWwQu/ecjShoddmZR9CeYknk4gIuIKwwvi0RuWYN9iKCTGKTNJg32s+ocQj8PX
 D+Xkh3mZGkAjgMrc7cA6Nn9medVux1KNx+yhi+VAX3Tk+lpZ1MPvODRexKQ3sNh3ck
 AvsCnZV3Q02VcsWf7DzqQwKTNVv5bqi6ynKIm2yRmEm/QJUkduDbScknK/ZOCAqzu/
 V2Koa1qoL27B0oo3Z6nDAkKPOmMdPzJW9pdiUcof2MfFFfaDRyIwLDNh024ftJPMdj
 x8lqVVT6GPK6A==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Thierry Reding <treding@nvidia.com>, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Jonas =?utf-8?Q?Schw?=
 =?utf-8?Q?=C3=B6bel?=
 <jonasschwoebel@yahoo.de>, Ion Agorria <ion@agorria.com>, Peter Geis
 <pgwipeout@gmail.com>, u-boot@lists.denx.de
Subject: Re: [PATCH v1 1/9] fastboot: Add
 board_fastboot_flash/erase/get_part_info hooks
In-Reply-To: <CAPVz0n3HUqT+TqyRrkyc83r-sDXMcMEXpqPPYxhinvp1rs8pDQ@mail.gmail.com>
References: <20260930075527.92697-1-clamor95@gmail.com>
 <20260930075527.92697-2-clamor95@gmail.com>
 <xhkdbfqy567t3.fsf@mkorpers-koolstof.csb>
 <xhkdbcxt65btd.fsf@mkorpers-koolstof.csb>
 <CAPVz0n3HUqT+TqyRrkyc83r-sDXMcMEXpqPPYxhinvp1rs8pDQ@mail.gmail.com>
Date: Wed, 18 Nov 2026 11:08:27 +0100
Message-ID: <xhkdbse0ypi3o.fsf@mkorpers-koolstof.csb>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_FAIL,SPF_HELO_NONE autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Svyatoslav,

Sorry for the delay in replying,

On Mon, Oct 19, 2026 at 12:26, Svyatoslav Ryhel <clamor95@gmail.com> wrote:

> =D0=BF=D0=BD, 19 =D0=B6=D0=BE=D0=B2=D1=82. 2026=E2=80=AF=D1=80. =D0=BE 11=
:33 Mattijs Korpershoek <mkorpershoek@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
>>
>> On Fri, Oct 16, 2026 at 16:26, Mattijs Korpershoek <mkorpershoek@kernel.=
org> wrote:
>>
>> > Hi Svyatoslav,
>> >
>> > Thank you for the patch.
>> >
>> > On Wed, Sep 30, 2026 at 10:55, Svyatoslav Ryhel <clamor95@gmail.com> w=
rote:
>> >
>> >> From: Ion Agorria <ion@agorria.com>
>> >>
>> >> This allows boards to intercept fastboot flash/erase and modify/change
>> >> behavior according to board specifics like AES encryption or RSA sign=
ing.
>> >> Add board_fastboot_get_part_info to provide info as fastboot tool que=
ries
>> >> during flash/erase.
>>
>> I've given this some more thought over the weekend. We already have an
>> 'oem board' command in fastboot.
>>
>> See:
>> https://docs.u-boot-project.org/en/latest/android/fastboot.html#overview
>>
>> Have we considered using the 'oem board' command instead of adding
>> another board specific command?
>
> You are mixing up. This patch does not add any vendor commands. It
> allows using native commands with vendor quirks seamlessly.

I know it's not exactly the same thing. I'm just worried these extra
hooks will make stuff less maintainable in the long run.

>
> For example. Tegra devices require bootloader and bct to be encrypted
> and bct to be updated every time bootloader is flashed.
>
> $ fastboot stage bootloader.img
> $ fastboot oem board:write_bootloader
>
> Used has to stage bootloader, then write is with some custom vendor
> bootloader flashing command which we have to make, document etc etc.
>
> This series allows intercept native fastboot commands of flashing some
> partitions and apply vendor specific adjustments directly. So I can
> flash bootloader, boot and system with native command `fastboot flash`
> but bootloader flashing will be performed with encryption and does not
> require from user any additional movements.

I understand, that it might be easier from a user experience point of
view (just fastboot flash <whatever partition>)

But adding extra vendor hooks also means having a specification of what ven=
dors
should do in these hooks: adding docstrings, adding documentation in the
fastboot.rst page and such.

I'm not NACKING this series, I just wish to discuss in more detail why
'oem board' is a wrong idea.

For example, do you have a closed-source userspace that forces you to
use 'fastboot flash' on tegra devices?

>
> board_fastboot_get_part_info allows filtering partitions to flash sent
> by fastboot flash command and board_fastboot_flash implements vendor
> hook to flash this partition.
>
> And this is not restricted to bootloader partition only.
>
>>
>> The documentation also gives an example on custom flashing, see:
>> https://docs.u-boot-project.org/en/latest/android/fastboot.html#running-=
custom-vendor-code
>>
>> >>
>> >> Signed-off-by: Ion Agorria <ion@agorria.com>
>> >> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
>> >
>> > This patch does not apply on main
>> > commit fed92546960a ("Gitlab CI: sage: Update for labgrid 26.0 behavio=
r")
>> >
>> > I'll try to review it anyways, but please consider resubmitting it aft=
er rebasing.
>> >
>> >> ---
>> >>  drivers/fastboot/fb_command.c | 20 ++++++++++++++++++++
>> >>  drivers/fastboot/fb_getvar.c  | 12 ++++++++++++
>> >>  2 files changed, 32 insertions(+)
>> >>
>> >> diff --git a/drivers/fastboot/fb_command.c b/drivers/fastboot/fb_comm=
and.c
>> >> index 18d86988f4c..284d771fe31 100644
>> >> --- a/drivers/fastboot/fb_command.c
>> >> +++ b/drivers/fastboot/fb_command.c
>> >> @@ -17,6 +17,17 @@
>> >>  #include <vsprintf.h>
>> >>  #include <linux/printk.h>
>> >>
>> >
>> > Please document the function. Especially the return code so that
>> > board-specific implementations know what to do.
>> >
>> >> +__weak int board_fastboot_flash(char *cmd_parameter, void *download_=
buffer,
>> >> +                            u32 download_bytes, char *response)
>> >> +{
>> >> +    return 0;
>> >
>> > Why 0?
>> >
>> > Can we please use a more meaningful error code here? -ENOTSUPP for exa=
mple.
>> >
>> >> +}
>> >> +
>> >> +__weak int board_fastboot_erase(char *cmd_parameter, char *response)
>> >> +{
>> >> +    return 0;
>> >
>> > Same.
>> >
>> >> +}
>> >> +
>> >>  /**
>> >>   * image_size - final fastboot image size
>> >>   */
>> >> @@ -339,6 +350,11 @@ void fastboot_data_complete(char *response)
>> >>   */
>> >>  static void __maybe_unused flash(char *cmd_parameter, char *response)
>> >>  {
>> >> +    if (IS_ENABLED(CONFIG_FASTBOOT_FLASH) &&
>> >> +        board_fastboot_flash(cmd_parameter, fastboot_buf_addr,
>> >> +                             image_size, response))
>> >> +            return;
>> >> +
>> >>      if (IS_ENABLED(CONFIG_FASTBOOT_FLASH_BLOCK))
>> >>              fastboot_block_flash_write(cmd_parameter, fastboot_buf_a=
ddr,
>> >>                                         image_size, response);
>> >> @@ -367,6 +383,10 @@ static void __maybe_unused flash(char *cmd_param=
eter, char *response)
>> >>   */
>> >>  static void __maybe_unused erase(char *cmd_parameter, char *response)
>> >>  {
>> >> +    if (IS_ENABLED(CONFIG_FASTBOOT_FLASH) &&
>> >> +        board_fastboot_erase(cmd_parameter, response))
>> >> +            return;
>> >> +
>> >>      if (IS_ENABLED(CONFIG_FASTBOOT_FLASH_BLOCK))
>> >>              fastboot_block_erase(cmd_parameter, response);
>> >>
>> >> diff --git a/drivers/fastboot/fb_getvar.c b/drivers/fastboot/fb_getva=
r.c
>> >> index e8aa0e09aa6..af65fca548f 100644
>> >> --- a/drivers/fastboot/fb_getvar.c
>> >> +++ b/drivers/fastboot/fb_getvar.c
>> >> @@ -29,6 +29,12 @@ static void getvar_partition_type(char *part_name,=
 char *response);
>> >>  static void getvar_partition_size(char *part_name, char *response);
>> >>  static void getvar_is_userspace(char *var_parameter, char *response);
>> >>
>> >> +__weak int board_fastboot_get_part_info(const char *part_name, char =
*response,
>> >> +                                    size_t *size)
>> >> +{
>> >> +    return 1;
>> >
>> > Why 1?
>> >
>> > What happens if a board_fastboot_get_part_info() returns 1 here?
>> >
>> > Also if we look at the documentation of part_get_info_by_name():
>> > """
>> >  * part_get_info_by_name() - Search for a partition by name
>> >  *                           among all available registered partitions
>> >  *
>> >  * @desc:     block device descriptor
>> >  * @name:     the specified table entry name
>> >  * @info:     returns the disk partition info
>> >  *
>> >  * Return: the partition number on match (starting on 1), -1 on no mat=
ch,
>> >  * otherwise error
>> >  */
>> > int part_get_info_by_name(struct blk_desc *desc, const char *name,
>> >                         struct disk_partition *info);
>> > """
>> >
>> > So 1 can be confusing.
>> >
>> > Can't we return something like -ENOTSUPP instead?
>> > That makes it more clear that this is a stub operation that can be
>> > re-implemented by each board.
>> >
>> >> +}
>> >> +
>> >>  static const struct {
>> >>      const char *variable;
>> >>      bool list;
>> >> @@ -116,6 +122,12 @@ static int getvar_get_part_info(const char *part=
_name, char *response,
>> >>      struct disk_partition disk_part;
>> >>      struct part_info *part_info;
>> >>
>> >> +    if (IS_ENABLED(CONFIG_FASTBOOT_FLASH)) {
>> >> +            r =3D board_fastboot_get_part_info(part_name, response, =
size);
>> >> +            if (r !=3D 1)
>> >> +                    return r;
>> >> +    }
>> >> +
>> >>      if (IS_ENABLED(CONFIG_FASTBOOT_FLASH_BLOCK)) {
>> >>              r =3D fastboot_block_get_part_info(part_name, &dev_desc,=
 &disk_part,
>> >>                                               response);
>> >> --
>> >> 2.53.0
