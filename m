Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C652E7C4F1
	for <u-boot@archiver.kernel.org>; Wed,  4 Oct 2023 20:14:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3080C874F4;
	Wed,  4 Oct 2023 22:14:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=goldsimon@gmx.de header.b="Emg5BHla";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AF157875AE; Wed,  4 Oct 2023 22:14:53 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 97DDB874EC
 for <u-boot@lists.denx.de>; Wed,  4 Oct 2023 22:14:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=goldsimon@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1696450483; x=1697055283; i=goldsimon@gmx.de;
 bh=q0wh5ChI/wWFTRasFFKoKzNq3pWSGgfMdVBsigXcs24=;
 h=X-UI-Sender-Class:Date:From:To:CC:Subject:In-Reply-To:References;
 b=Emg5BHlap0kGlehSmrICA+a/wCEfAjmxbDSKQ6a0C84BTGB9T+6Ld3ciL7oEMIvFj7+i/0TAnhB
 btWIwpso/4VMDw90HvAdgS93jYvqUtupiU15dvP2kEEnUhkt9MymIpqqRxIy1PitoXt7Bo0hjhq/D
 /OS/eHoakkqP7q4M+XRZHhklvww27cW/WiFXNvI99O09mi8pK+yUr0HvFETyC5yCy6Un6qI/0d48d
 fro36B35hXOw3gKlMzi8jEmFkYgK8PvD+5f0xUIBDZ1YKVNp7MSyQnSSTlFGT+05jzziKa8Sd6IeD
 aagUWerzQSXLHWG9PUY0oIihwdUEMIaUZspw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [127.0.0.1] ([176.199.209.230]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MiJVG-1rIFka3S10-00fWDK; Wed, 04
 Oct 2023 22:14:42 +0200
Date: Wed, 04 Oct 2023 22:14:40 +0200
From: Simon Goldschmidt <goldsimon@gmx.de>
To: Maxim Uvarov <maxim.uvarov@linaro.org>, Simon Glass <sjg@google.com>
CC: Sean Edmond <seanedmond@linux.microsoft.com>, u-boot@lists.denx.de,
 pbrobinson@gmail.com, ilias.apalodimas@linaro.org, joe.hershberger@ni.com,
 rfried.dev@gmail.com, trini@konsulko.com
Subject: =?US-ASCII?Q?Re=3A_=5BPATCHv10_14/15=5D_net/lwip=3A_repl?=
 =?US-ASCII?Q?ace_original_net_commands_with_lwip?=
User-Agent: K-9 Mail for Android
In-Reply-To: <CAD8XO3Yj0vCnTx81UwvpWsQiSyyJkMBQG4qn8qSWq2cnS1Ugfw@mail.gmail.com>
References: <20230926094124.7024-1-maxim.uvarov@linaro.org>
 <20230926094124.7024-15-maxim.uvarov@linaro.org>
 <77c30b7d-66ae-a7ff-0e7d-07be3098acbc@linux.microsoft.com>
 <CAPnjgZ3a5MVTKEzDwnYGiRW+cvz5H-v7ictRUTeUjWJUKV1D9g@mail.gmail.com>
 <CAD8XO3Yj0vCnTx81UwvpWsQiSyyJkMBQG4qn8qSWq2cnS1Ugfw@mail.gmail.com>
Message-ID: <F6207291-222C-4B9A-B093-9ACD593B0611@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:37ZnSsu/AojZXqE1HEw9KTeag1Ju1hyjEz/ng9X3WycE9AzLzBN
 CULBVNcvZolyxLP1yKQyHjfFoCd310ld7o9KEGYu+9yhNS04apLSiSqmiK0yzKVzy0vKf+P
 9/prKFUNOAiN3TtqA4ThPF4gyxqvuRHnur/lNtFEpv6nBK1jGxiiCtgJp6U5QQmnaHE+Wmd
 FZBnsXG883T1dTMSVVYqQ==
UI-OutboundReport: notjunk:1;M01:P0:RbwHHx/qNBk=;phoRYJzHwYfc31rIFRtJRXBLgU1
 dC48lzPRsvnlGfcy2uv7FRipxzOpHtluatO8wZYWDJC4JU98AKMyUreAGAJa9SlxqFeLSs5Ss
 +7yW1BEk4kexBsN/TOCpeYhxqEt+Dp3BRVAOg++ibVxjT+lw8RFj+ndNlwekiWcEuGBnCDu8z
 CPlbWA8sAhXZ3UJAxxt+nvcKiclbIOHWOhqJXzyN6whRoQi1hj1bD9EjEO8aRfPf94G7+esnF
 OWko/tNPHJpAzd4pvyZO8rdSyJLSclsuNQc967MsOjyDzabkYVDjC1kLMdtVcI4XeiasP8TdO
 zjARMr3TSRyULww6T9hg1RddR6H/hYts44uSff8KesExrvYKtueS2injhpMjsJAbnGZ1LIaKp
 0A48HQ1+saI7//fzM25XWfA6+O2vq4ZU0QExn9oPR2k/ntUMldxqxKgCZAbBiRPbzeSEoa/QF
 wEloUmmkgk2374b+UgpTNMNBrBqGFPTDRQmSJ5sfsXsKg71rYDdZQyEs6+p3isyB8I6NyKc+k
 34Bt01CvnD4Lmbdf5tSHkUYcW+nfI7Tpn7PPGRWw9GLd702xsBh98MleIW6ZWZhU60yEkjQh5
 Y2hcuEmoAt7bjZ0DrST5XuKYrH0vlDqQSWYu1LaFcZRN8lDyahuhUD3Li08nIvN0sqqXQYwKI
 TYe3Q9UUIvYCjpvpbsoAlCThEFtGN25qtd+7QoFjTBXovybRhxOBr050HFYqoGgMKyhL5bHNF
 EneHNFKvZe8SD6A7rhJkRr4oW80CakA8ISQt9NjInMss56NEeXLqLwHqMPxS8IOjLaYNgm6Xa
 joLvDkSKZ+udAGDl7Jmkw6NKaZwP+5pihIe6stzma8v4j/d3UpptH9DHIT4wEhEwQfjwsWS1l
 u6g7afykBS4rpJtKyePZ6la+qZ+tydULK9NYuiENDneaL3i2QZWOZV9xpVlVULVZ125TKGM0q
 bLJYK7rUKH/DyeALNeU0vK74WfE=
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



Am 4=2E Oktober 2023 10:29:54 MESZ schrieb Maxim Uvarov <maxim=2Euvarov@li=
naro=2Eorg>:
>On Wed, 4 Oct 2023 at 08:12, Simon Glass <sjg@google=2Ecom> wrote:
>
>> Hi Sean,
>>
>> On Tue, 3 Oct 2023 at 11:58, Sean Edmond <seanedmond@linux=2Emicrosoft=
=2Ecom>
>> wrote:
>> >
>> >
>> > On 2023-09-26 2:41 a=2Em=2E, Maxim Uvarov wrote:
>> > > Replace original commands: ping, tftp, dhcp and wget=2E
>> > >
>> > > Signed-off-by: Maxim Uvarov<maxim=2Euvarov@linaro=2Eorg>
>> > > ---
>> > >   boot/bootmeth_efi=2Ec | 18 +++++++---
>> > >   boot/bootmeth_pxe=2Ec | 21 ++++++-----
>> > >   cmd/net=2Ec           | 86
>> +++++----------------------------------------
>> > >   cmd/pxe=2Ec           | 19 +++++-----
>> > >   include/net=2Eh       |  8 +++--
>> > >   include/net/ulwip=2Eh | 64 +++++++++++++++++++++++++++++++++
>> > >   6 files changed, 113 insertions(+), 103 deletions(-)
>> > >   create mode 100644 include/net/ulwip=2Eh
>> > >
>> > > diff --git a/boot/bootmeth_efi=2Ec b/boot/bootmeth_efi=2Ec
>> > > index ae936c8daa=2E=2E52399d627c 100644
>> > > --- a/boot/bootmeth_efi=2Ec
>> > > +++ b/boot/bootmeth_efi=2Ec
>> > > @@ -20,6 +20,8 @@
>> > >   #include <mapmem=2Eh>
>> > >   #include <mmc=2Eh>
>> > >   #include <net=2Eh>
>> > > +#include <net/lwip=2Eh>
>> > > +#include <net/ulwip=2Eh>
>> > >   #include <pxe_utils=2Eh>
>> > >   #include <linux/sizes=2Eh>
>> > >
>> > > @@ -319,9 +321,7 @@ static int distro_efi_try_bootflow_files(struct
>> udevice *dev,
>> > >
>> > >   static int distro_efi_read_bootflow_net(struct bootflow *bflow)
>> > >   {
>> > > -     char file_addr[17], fname[256];
>> > > -     char *tftp_argv[] =3D {"tftp", file_addr, fname, NULL};
>> > > -     struct cmd_tbl cmdtp =3D {};      /* dummy */
>> > > +     char fname[256];
>> > >       const char *addr_str, *fdt_addr_str;
>> > >       int ret, arch, size;
>> > >       ulong addr, fdt_addr;
>> > > @@ -368,7 +368,6 @@ static int distro_efi_read_bootflow_net(struct
>> bootflow *bflow)
>> > >       if (!fdt_addr_str)
>> > >               return log_msg_ret("fdt", -EINVAL);
>> > >       fdt_addr =3D hextoul(fdt_addr_str, NULL);
>> > > -     sprintf(file_addr, "%lx", fdt_addr);
>> > >
>> > >       /* We only allow the first prefix with PXE */
>> > >       ret =3D distro_efi_get_fdt_name(fname, sizeof(fname), 0);
>> > > @@ -379,7 +378,16 @@ static int distro_efi_read_bootflow_net(struct
>> bootflow *bflow)
>> > >       if (!bflow->fdt_fname)
>> > >               return log_msg_ret("fil", -ENOMEM);
>> > >
>> > > -     if (!do_tftpb(&cmdtp, 0, 3, tftp_argv)) {
>> > > +     ret =3D ulwip_init();
>> > > +     if (ret)
>> > > +             return log_msg_ret("ulwip_init", ret);
>> > > +
>> > > +     ret =3D ulwip_tftp(fdt_addr, fname);
>> > > +     if (ret)
>> > > +             return log_msg_ret("ulwip_tftp", ret);
>> > > +
>> > > +     ret =3D ulwip_loop();
>> > > +     if (!ret) {
>> > >               bflow->fdt_size =3D env_get_hex("filesize", 0);
>> > >               bflow->fdt_addr =3D fdt_addr;
>> > >       } else {
>> > > diff --git a/boot/bootmeth_pxe=2Ec b/boot/bootmeth_pxe=2Ec
>> > > index 8d489a11aa=2E=2Efc6aabaa18 100644
>> > > --- a/boot/bootmeth_pxe=2Ec
>> > > +++ b/boot/bootmeth_pxe=2Ec
>> > > @@ -21,6 +21,8 @@
>> > >   #include <mapmem=2Eh>
>> > >   #include <mmc=2Eh>
>> > >   #include <net=2Eh>
>> > > +#include <net/ulwip=2Eh>
>> > > +#include <net/lwip=2Eh>
>> > >   #include <pxe_utils=2Eh>
>> > >
>> > >   static int extlinux_pxe_getfile(struct pxe_context *ctx, const ch=
ar
>> *file_path,
>> > > @@ -116,18 +118,21 @@ static int extlinux_pxe_read_file(struct udev=
ice
>> *dev, struct bootflow *bflow,
>> > >                                 const char *file_path, ulong addr,
>> > >                                 ulong *sizep)
>> > >   {
>> > > -     char *tftp_argv[] =3D {"tftp", NULL, NULL, NULL};
>> > > -     struct pxe_context *ctx =3D dev_get_priv(dev);
>> > > -     char file_addr[17];
>> > >       ulong size;
>> > >       int ret;
>> > >
>> > > -     sprintf(file_addr, "%lx", addr);
>> > > -     tftp_argv[1] =3D file_addr;
>> > > -     tftp_argv[2] =3D (void *)file_path;
>> > > +     ret =3D ulwip_init();
>> > > +     if (ret)
>> > > +             return log_msg_ret("ulwip_init", ret);
>> > > +
>> > > +     ret =3D ulwip_tftp(addr, file_path);
>> > > +     if (ret)
>> > > +             return log_msg_ret("ulwip_tftp", ret);
>> > > +
>> > > +     ret =3D ulwip_loop();
>> > > +     if (ret)
>> > > +             return log_msg_ret("ulwip_loop", ret);
>> > >
>> > > -     if (do_tftpb(ctx->cmdtp, 0, 3, tftp_argv))
>> > > -             return -ENOENT;
>> > >       ret =3D pxe_get_file_size(&size);
>> > >       if (ret)
>> > >               return log_msg_ret("tftp", ret);
>> > > diff --git a/cmd/net=2Ec b/cmd/net=2Ec
>> > > index d407d8320a=2E=2Edc5a114309 100644
>> > > --- a/cmd/net=2Ec
>> > > +++ b/cmd/net=2Ec
>> > > @@ -22,6 +22,7 @@
>> > >   #include <net/udp=2Eh>
>> > >   #include <net/sntp=2Eh>
>> > >   #include <net/ncsi=2Eh>
>> > > +#include <net/lwip=2Eh>
>> > >
>> > >   static int netboot_common(enum proto_t, struct cmd_tbl *, int, ch=
ar
>> * const []);
>> > >
>> > > @@ -40,19 +41,9 @@ U_BOOT_CMD(
>> > >   #endif
>> > >
>> > >   #ifdef CONFIG_CMD_TFTPBOOT
>> > > -int do_tftpb(struct cmd_tbl *cmdtp, int flag, int argc, char *cons=
t
>> argv[])
>> > > -{
>> > > -     int ret;
>> > > -
>> > > -     bootstage_mark_name(BOOTSTAGE_KERNELREAD_START, "tftp_start")=
;
>> > > -     ret =3D netboot_common(TFTPGET, cmdtp, argc, argv);
>> > > -     bootstage_mark_name(BOOTSTAGE_KERNELREAD_STOP, "tftp_done");
>> > > -     return ret;
>> > > -}
>> > > -
>> > >   #if IS_ENABLED(CONFIG_IPV6)
>> > >   U_BOOT_CMD(
>> > > -     tftpboot,       4,      1,      do_tftpb,
>> > > +     tftpboot,       4,      1, do_lwip_tftp,
>> >
>> > It looks like LWIP doesn't support TFTP with IPv6 addressing=2E  Perh=
aps
>> > we need to fall back onto the existing TFTP implementation until LWIP
>> > supports it?
>> >
>> > Note, that currently, IPv6 TFTP is enabled using the "-ipv6" argument=
=2E
>> > The intention is that netboot_common() sees the argument and sets the
>> > "use_ip6" variable=2E  It looks like the new implementation in
>> > do_lwip_tftp() doesn't re-use the argument parsing in netboot_common(=
)
>> > and that it doesn't handle the addition of the "-ipv6" flag=2E
>> >
>> > I support the addition of LWIP, but I'm concerned about how abrupt
>> > changes like this one will be for existing users=2E  The underlying s=
tack
>> > will change, with no easy way for the user to revert to the previous
>> > stack=2E Has there been any discussion about preserving the existing
>> > functionality, with an option to enable/disable LWIP stack?This would
>> > give the community time to transition/validate LWIP before deprecatin=
g
>> > the old u-boot networking stack=2E
>>
>> IPv6 is news to me=2E=2E=2Eand surprising=2E
>>
>> Regards,
>> Simon
>>
>
>For this time I enabled only ipv4 in lwip U-boot implementation and plann=
ed
>to keep the original ping6 dhcp6 tftp6 on first submission=2E After the f=
irst
>ipv4 lwip patches can be merged I planned to work on ipv6 support=2E  I t=
hink
>it will require more time for the test environment to be set up, then
>actually enabling ipv6 in the configuration header=2E lwIP can work in du=
al
>stack mode=2E But I'm not sure that example applications support ipv6 at =
this
>time=2E

All lwIP example apps building on UDP or TCP should support IPv6 just fine=
=2E Ping is of course a special case in that it uses a different protocol f=
or IPv6 and IPv4 and no one has bothered yet to port it to IPv6=2E That's t=
he reason it remained in contrib/apps instead of src/apps=2E

Aside from DNS, we do not have built in a fallback mechanism from IPv6 to =
IPv4 or the other way around, so that would have to be coded by the applica=
tion (U-Boot command in this case)=2E

Regards,
Simon
