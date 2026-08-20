Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A193CC5DF82
	for <u-boot@archiver.kernel.org>; Thu, 20 Aug 2026 17:59:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id BA43480EE2;
	Thu, 20 Aug 2026 17:59:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id owxqUs9mM_Cw; Thu, 20 Aug 2026 17:59:11 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787248751;
	bh=pSGZfBVjENVkNFPUO2wXcJwSR3fNWsUPl9oGHX4KcWA=;
	h=To:Cc:From:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=pU3lhwUZkbOg4qBdaXyVUkil6RDOLxfx1lGjglx0WbNxr9YVzwZqk4s6uefTxsJTU
	 YzpfeTiwsdL37Wr9KcNwIX2WmbFKBg0rTriNfe3NZ6dBUNneq8aLgUF6sNIPC+07wN
	 yceJUvwjlHuyRfzqDp/dcko2Q8e7hOarqs/mIb27C0UMsFa6vFBKDx40u0iuWT4wGV
	 OA+fqw5wkDnTSeDc1amJaUsOshU1fgQXVdIhyoKeJX7rGW09YZFhk92FAcUal506U3
	 oMec4vRCguOWGmJIs21tP8UoJ1393O6mJsA20SReYGePdCQAyyUO8Rth1x3LXwONcE
	 KYUgKGkGTOSvQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5DF8280ED7;
	Thu, 20 Aug 2026 17:59:11 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id E8F661B8
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 17:59:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E65BF607EE
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 17:59:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZS_Bj_v6Lywt for <u-boot@lists.u-boot-project.org>;
 Thu, 20 Aug 2026 17:59:08 +0000 (UTC)
X-Greylist: delayed 4659 seconds by postgrey-1.37 at util1.osuosl.org;
 Thu, 20 Aug 2026 17:59:08 UTC
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=icloud.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=icloud.com header.i=@icloud.com header.a=rsa-sha256
 header.s=1a1hai header.b=jqyxFmA4
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:b747:3006:207::71; helo=outbound.qs.icloud.com;
 envelope-from=valentinliu@icloud.com; receiver=<UNKNOWN> 
Received: from outbound.qs.icloud.com (qs-2002k-snip6-11.eps.apple.com
 [IPv6:2a01:b747:3006:207::71])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 76411606C2
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 17:59:08 +0000 (UTC)
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-60-percent-4 (Postfix) with ESMTPS id
 3433F180010C; Thu, 20 Aug 2026 16:41:27 +0000 (UTC)
X-ICL-RepId: 01a0200c-878a-7d8c-a018-8ddf531602ef
X-ICL-Out-Info: HUtFAUMEWwJACUgBTUQeDx5WFlZNRAJCTQ9IHV8FWhxEC1YCXwBLVxQEDlIBUgVGGVcUWhh3AlEcVg1XQ1QEX1BfHA4EVAddBV1WUAJaS0ATBEkDTV8OXh8EF0YZVQRHHl1WQh4ZAlEcVg1XQ1QEX1BJDEFQbFoARxdIHV0ZWW9QXRwOBFQHXQVdVlACWktfGV1FD10CDQQSDUABQFEJC0EUTApaDkZTRQhLHg4OUgNGDE9RWAIJUDBUHR0OWAYMUE0BQwgKAlEcVg1X
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com; s=1a1hai;
 t=1787244088; x=1789836088; bh=pSGZfBVjENVkNFPUO2wXcJwSR3fNWsUPl9oGHX4KcWA=;
 h=To:From:Subject:Date:Message-id:Content-Type:MIME-Version:x-icloud-hme;
 b=jqyxFmA4hmjDXDjiK36Z4J3o3N8wCx0HHADBOq0gKAZpMGJhqDJu6eudry1yRrUwP4sS9/f8bdwB2hxJgaH4J8W1HK1HHWeUrlUuieaOfw1yqiILtIIKmPhtml6crQtEEPdMWOf7DGg/c91jqddLUmyTsflWCtUKk40G09oSupf+FXtTFh03n2ZwenW2zvrxNKfuygo18MvUAfO8oAH0FBbCLZ2Utrj3Nj/JMlaFQFmcSj+TJwpYbohEBUzR+OfldXCIbUpyv+iLBpO2Wj25/ZNUHe5eAw+OdDkjSuz6PxIOyvWTttRjTTuzM82XvzZFXd8U99KTqvj901zftvtHKA==
Received: from p00-mailws2-7c9f864df-l5m9q (unknown [10.112.113.19])
 by p00-icloudmta-asmtp-us-east-2d-60-percent-4 (Postfix) with ESMTPSA id
 C068F1800150; Thu, 20 Aug 2026 16:41:26 +0000 (UTC)
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.u-boot-project.org, mkorpershoek@kernel.org, sjg@chromium.org,
 trini@konsulko.com, igor.opaniuk@gmail.com, alchark@flipper.net,
 quentin.schulz@cherry.de, marek.vasut+renesas@mailbox.org,
 daniel@makrotopia.org, rs@ti.com
From: =?utf-8?B?5YiY5Z6j6L6w?= <valentinliu@icloud.com>
Subject: =?utf-8?B?UmXvvJpSZTogW1BBVENIIHYxIDEvMl0gYm9vdDogYW5kcm9pZDogQWRkIEFu?=
 =?utf-8?B?ZHJvaWQgMTMrIGJvb3RmbG93IHN1cHBvcnQgdG8gYm9vdG1ldGgu?=
Date: Thu, 20 Aug 2026 16:41:26 +0000 (GMT)
X-Mailer: iCloud MailClient2630Hotfix39 MailServer2612B5.952a5ad53a12
Message-id: <05f6b482-fb91-4979-a513-c991657b55bb@me.com>
Content-Type: multipart/alternative;
 boundary=Apple-Webmail-42--200cbcb5-fec1-46fd-a78b-64dee29fa0c9
MIME-Version: 1.0
In-Reply-To: <CAFLszTj8g4xxzt9A7txOhDMU6hLe2=twZoZPo_sr7Z5m=6BC4A@mail.gmail.com>
References: <20260818175301.818739-1-valentinliu@icloud.com>
 <CAFLszTj8g4xxzt9A7txOhDMU6hLe2=twZoZPo_sr7Z5m=6BC4A@mail.gmail.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIwMDEyNiBTYWx0ZWRfX0Tu/0JI0RP+1
 tQFtDpkKvuUkiTx7yzqkMI0LscgAtUeSnZ1LZ8aJZaNwklB1P/OtwiBFLkqtFVcl/7bN5mKTxg4
 hDrc2auvAZy6HcAehQhWn55A+13QJWyH9mTJuDG656z0eVLbcCiv9fmcpexUYw6WIU/lemShYry
 sNMhvMcAEDS5XGu3l4UYbFm77m3a4xt5oSoL+n+mXieXFCbbMd3yADu/rFTMlxR05FEXA8oZohs
 ycTRFmSgXp9HfOxt5+Dci88cNSQbbiZhCmjFJrxaQ6nI/9FPs/0Fi+JDKEt1qFca/BW6B71w6EG
 hvvTVCg6ZwZrfihmi+Qbpl4OVUBwa4NeTT+4j8N2/XfeUf1rRB1dZlnwkoTGSY=
X-Proofpoint-GUID: WT038RzobmT-8c0_Cf1xmfuit9DSakQX
X-Authority-Info-Out: v=2.4 cv=B7W0EetM c=1 sm=1 tr=0 ts=6a872e37
 cx=c_apl:c_pps:t_out a=w0vwr1DNSLjGex3smDq1Tg==:117 a=Sv0fKeRqtYgA:10
 a=5KLPUuaC_9wA:10 a=M51BFTxLslgA:10 a=x7bEGLp0ZPQA:10 a=LQAHsTbMm04A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=n8i27M1mAAAA:8 a=cm27Pg_UAAAA:8 a=v3ZZPjhaAAAA:8
 a=rqSaIuZxQEJTNYWQdCoA:9 a=QEXdDO2ut3YA:10 a=oaD18fx_N2-gzAGGHbgA:9
 a=Pr9vB8IlYEMs_PBL:21 a=_W_S_7VecoQA:10
X-Proofpoint-ORIG-GUID: WT038RzobmT-8c0_Cf1xmfuit9DSakQX
X-JNJ: AAAAAAABqYwDMAjj/b0hrCrHX8HW9z58E78gso1IntE0G0pMj4ZAaYsq2SnRS/rSW11c3LX0JppKNAzixSkA6RuQJeK26aTxxZnC95SWn7WSWOr7sh+ExfhT5VIasZZmWy+x8BQweq0LnMSD6F1WGPB5F5pWVNtUWZ8neRqYMYd5kIxoZryAQLripIoo8maggyMgKyNznBwutzv1PjYA2SQEX+MFdBjXypJ+sPoWZNuSE9HCvUPtegqaS6yysCprNBntm8KSNF9fpb4IAGNW3bs1T1IsYQdUY73/WBM0fpP7byqnBXZarkKl+3uCmT61Yprq7ZRxpcYfFMwoLSl5hK2WGGrLS61h9c1qo98rtGeMjJO3sE1kOfydGMZqhv6DmzW8ieoXx7XrBkMFN5x6XIsFyQiDufmUfJ+PigY2cSq+8n4UQTHTnUjsWTP2fUOQL8j9WJOztpcV4KDOi3ESOBUxEyanvXXg34TF698Ziz33DjIimEqOX7GUrzZRWw7sskFLMurXuJAtTMQq9gYJa8LuUz7zsy+8HtpSRYFpGFjCUfb/4j75xsX3JtKpj7sd0Y8RBao/X+m21tCLFhrp6eAm+GAFv7oh+iG09lWY6jJ07u2Gxj1x11MyDORavXtb4i6wCXu9V2OXMWYmNN+16tjDWgHCrDRO8rD5nxr8+7AFcxtlLqH2M6N3from4mM+jCAT3AY73JhvmFlaIxYZJ1/Is6ksOHTOFY0xJraPQhoYQxI50FyOTrfBZa3LWVAsUpVgfdolODlOy5GrzwSaWr2D0bmhjPxI3niy6Fy2Qt0lxyWUapN1SG/xc4AswKjVenuvwF7cz29AFerRLCsWiwfA3YniIkrQW2/8ukc5F4I/TPlWehrg1HumOk3XEp5CfAMWaLhzKoYEEY3MZAMQeNFnIAZMa8XuMgpwZr0HYTFM4PuUayk8LNKet+qAslZvSdLCB3J7gLIC0Eake+jCVXQdXJeQ0OH
 v26TkPu1qKzmC62xHQXfRC5zatzjQNTNPMCD1kU2MtjRT09MibJxObLE8GjshSSp8qIgGYs0lYEJhIw6PrgNYO2bTK8/Yu1fVtCYgoA9jaa6zqNuAjYvc24p8SnXkEgCd0GsGNbEpuHQc4FZH1V6zGzInZLtske5bDDqtiqEnfuKZn7RfOpE7xRWWdYKdJHHrs8LVSBssPVBisn/D6pYzY9Fvs6gJClcdhkIojs46tCvUt3EF2jukaWtvNck6FmAyQIgjZ4sAISCsuINxXZxZCQKVzkMw4vDW6kioyUgq7EsFi+wmd6nwPH1mN+qEWFxlp22+gI8P7ZcwxENelxfUmgoukVinB3UfEHlGGh4ftAwHpHsxVMQV4xZjZW00neH7a9pmFUhFPWAMBcGkk52KFh6cZO2gmQ4zWVFcm0DwgNiHdt3DVpmkR4YUf6jz4515rOWFJZdF0rOTMKGQAiEcAb2ulljRfyZ7XGdxdYJIqvIfMBC6a029wBJMlpWLxaOwhlRxIjhnqI7t14pzC1Qt
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


--Apple-Webmail-42--200cbcb5-fec1-46fd-a78b-64dee29fa0c9
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
    charset=utf-8;
    format=flowed

Hi Simon, Thanks for your reviewing and suggestions. I can merge all scann=
ing function into one "helper", just introduce a new variable to condition=
 which partition we needed. But I have no idea about test and document and=
 I have not seen anything in test/ or doc/ folder. Can you give me some ad=
vice? I will refactor the AVB logic in the next patch in future. Best rega=
rds, Valentin Liu 2026=E5=B9=B48=E6=9C=8820=E6=97=A5=E4=B8=8B=E5=8D=888:31=
=EF=BC=8CSimon Glass <sjg@chromium.org> =E5=86=99=E9=81=93=EF=BC=9A Hi Val=
entin, On 2026-08-18T17:53:00, Valentin Liu <valentinliu@icloud.com> wrote=
: boot: android: Add Android 13+ bootflow support to bootmeth. Please drop=
 the trailing period and keep the subject under 60 characters. The devices=
 launching Android 13+ were using a new partition named init_boot to store=
 generic ramdisk. In the new bootflow, kernel still be stored in boot imag=
e, however, the First Stage files in ramdisk were moved to init_boot image=
. We should load it to memory and verify it so that the kernel can execute=
 init program to continue booting. Currently, we have supported loading th=
e init_boot image by abootimg command, but we still need bring this abilit=
y to bootmeth, so that booting Android 13+ will be more easily. Please use=
 present/imperative tense throughout: 'were using' -> 'use', 'kernel still=
 be stored' -> 'the kernel is still stored', 'were moved' -> 'are moved', =
'we still need bring' -> 'we still need to bring', 'more easily' -> 'easie=
r'. In the new bootflow, kernel still be stored in boot image, however, th=
e First Stage files in ramdisk were moved to init_boot image. We should lo=
ad it to memory and verify it so that the kernel can execute init program =
to continue booting. Currently, we have supported loading the init_boot im=
age by abootimg command, but we still need bring this ability to bootmeth,=
 so that booting Android 13+ will be more easily. Bootmeth will be able to=
 recognize the new partition layout, and boot Android normally. Link: http=
s://source.android.com/docs/core/architecture/partitions/generic-boot Sign=
ed-off-by: Valentin Liu <valentinliu@icloud.com> boot/bootmeth_android.c |=
 67 ++++++++++++++++++++++++++++++++++++++++ boot/image-android.c | 16 +++=
+++++++ cmd/abootimg.c | 5 +++ doc/develop/bootstd/overview.rst | 3 ++ inc=
lude/android_image.h | 1 + include/image.h | 35 +++++++++++++++++++++ 6 fi=
les changed, 127 insertions(+) Please can you look at how to add a test fo=
r this addition? diff --git a/boot/bootmeth_android.c b/boot/bootmeth_andr=
oid.c @@ -113,6 +115,51 @@ static int scan_boot_part(struct udevice *blk, =
struct android_priv *priv) +static int scan_init_boot_part(struct udevice =
*blk, struct android_priv *priv) +{ + struct blk_desc *desc =3D dev_get_uc=
lass_plat(blk); + struct disk_partition partition; + char partname[PART_NA=
ME_LEN]; + ulong num_blks, bufsz; + char *buf; + int ret; + + if (priv->sl=
ot) + sprintf(partname, INIT_BOOT_PART_NAME "_%s", priv->slot); + else + s=
printf(partname, INIT_BOOT_PART_NAME); This is a near-duplicate of scan_bo=
ot_part() and scan_vendor_boot_part(). Please factor the common logic (bui=
ld partname, read the header block, check magic, extract size) into a help=
er rather than adding a third copy. diff --git a/boot/bootmeth_android.c b=
/boot/bootmeth_android.c @@ -291,6 +338,17 @@ static int android_read_boot=
flow(struct udevice *dev, struct bootflow *bflow) + if (priv->header_versi=
on >=3D 4) { + ret =3D scan_init_boot_part(bflow->blk, priv); + if (ret < =
0) { + /* + * Android 12 devices do not have the init_boot partition. + * =
Some devices upgraded to Android 13 or later from + * earlier Android vers=
ions may also not have one. + */ + log_debug("scan init_boot failed: err=3D=
%d\n", ret); + } + } priv is allocated with plain malloc() above, so it is=
 not zeroed. On failure here priv->init_boot_img_size is left uninitialise=
d, then boot_android_normal() and (in patch 2) run_avb_verification() read=
 it back as 'priv->init_boot_img_size > 0'. Please use calloc()/memset(), =
or explicitly set priv->init_boot_img_size =3D 0 before the call and on th=
e failure path. diff --git a/boot/bootmeth_android.c b/boot/bootmeth_andro=
id.c @@ -556,6 +614,7 @@ static int boot_android_normal(struct bootflow *b=
flow) ulong loadaddr =3D env_get_hex("loadaddr", 0); + ulong iloadaddr =3D=
 env_get_hex("init_boot_comp_addr_r", 0); ulong vloadaddr =3D env_get_hex(=
"vendor_boot_comp_addr_r", 0); If init_boot_comp_addr_r is unset, env_get_=
hex() returns 0 and you silently load init_boot at address 0 and call set_=
ainit_bootimg_addr(0). Please check that iloadaddr is non-zero and error o=
ut with a clear message before using it - the vendor_boot path has the sam=
e weakness, but let's not extend the pattern. diff --git a/boot/image-andr=
oid.c b/boot/image-android.c @@ -326,6 +326,22 @@ bool android_image_get_d=
ata(const void *boot_hdr, const void *vendor_boot_hdr, +bool android_image=
_get_data_v4(const void *boot_hdr, const void *vendor_boot_hdr, + const vo=
id *init_boot_hdr, struct andr_image_data *data) +{ + if (!android_image_g=
et_data(boot_hdr, vendor_boot_hdr, data)) + return false; + + if (!is_andr=
oid_boot_image_header(init_boot_hdr)) { + printf("Incorrect init boot imag=
e header\n"); + return false; + } + + android_boot_image_v3_v4_parse_hdr(i=
nit_boot_hdr, data); + + return true; +} I can't find any caller of androi=
d_image_get_data_v4(). Please either wire it up to whatever consumes init_=
boot_img_total_size, or drop it (and the new struct field, and the header =
declaration) until it is needed. diff --git a/include/image.h b/include/im=
age.h @@ -2167,6 +2184,17 @@ bool android_image_print_dtb_contents(ulong h=
dr_addr); +/** + * is_android_init_boot_image_header() - Check the magic o=
f init boot image + * + * This checks the header of Android init boot imag=
e and verifies the + * magic is "ANDROID!" (same with the boot image) + * =
+ * @init_boot_img: Pointer to boot image + * Return: non-zero if the magi=
c is correct, zero otherwise + */ +bool is_android_init_boot_image_header(=
const void *init_boot_img); Declared but never defined or called - scan_in=
it_boot_part() uses is_android_boot_image_header() directly, which is corr=
ect since the magic is identical. Please drop the declaration. diff --git =
a/include/image.h b/include/image.h @@ -2199,6 +2227,13 @@ void set_abooti=
mg_addr(ulong addr); +/** + * set_ainit_bootimg_addr() - Set Android init =
boot image address + * + * Return: no returned results + */ +void set_aini=
t_bootimg_addr(ulong addr); Missing @addr: description, and a void functio=
n does not need a Return: line - please drop it. diff --git a/doc/develop/=
bootstd/overview.rst b/doc/develop/bootstd/overview.rst @@ -293,6 +293,9 @=
@ script_offset_f +init_boot_comp_addr_r + Address to which to load the in=
it_boot Android image, e.g. 0xd0000000 Since this env var is required for =
Android 13+ to boot, please also document it in the relevant board README(=
s) / sample env, and handle the missing case gracefully in the code (see c=
omment on boot_android_normal()). Regards, Simon
--Apple-Webmail-42--200cbcb5-fec1-46fd-a78b-64dee29fa0c9
Content-Type: multipart/related;
    type="text/html";
    boundary=Apple-Webmail-86--200cbcb5-fec1-46fd-a78b-64dee29fa0c9


--Apple-Webmail-86--200cbcb5-fec1-46fd-a78b-64dee29fa0c9
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
    charset=utf-8;

<html><body><div>Hi Simon,</div><div style=3D"font-family: &quot;SF Pro Text&quot;, sy=
stem-ui, sans-serif;"><br></div><div style=3D"font-family: &quot;SF Pro Te=
xt&quot;, system-ui, sans-serif;">Thanks for your reviewing and suggestion=
s.</div><div style=3D"font-family: &quot;SF Pro Text&quot;, system-ui, san=
s-serif;"><br></div><div style=3D"font-family: &quot;SF Pro Text&quot;, sy=
stem-ui, sans-serif;">I can merge all scanning function into one "helper",=
 just introduce a new variable to condition which partition we needed.</di=
v><div><br></div><div style=3D"font-family: &quot;SF Pro Text&quot;, syste=
m-ui, sans-serif;">But I have no idea about test and document and I have n=
ot seen anything in test/ or doc/ folder. Can you give me some advice?</di=
v><div style=3D"font-family: &quot;SF Pro Text&quot;, system-ui, sans-seri=
f;"><br></div><div style=3D"font-family: &quot;SF Pro Text&quot;, system-u=
i, sans-serif;">I will refactor the AVB logic in the next patch in future.=
</div><div style=3D"font-family: &quot;SF Pro Text&quot;, system-ui, sans-=
serif;"><br></div><div style=3D"font-family: &quot;SF Pro Text&quot;, syst=
em-ui, sans-serif;">Best regards,</div><div style=3D"font-family: &quot;SF=
 Pro Text&quot;, system-ui, sans-serif;">Valentin Liu</div><div style=3D"f=
ont-family: &quot;SF Pro Text&quot;, system-ui, sans-serif;"><br></div><bl=
ockquote type=3D"cite"><div>2026=E5=B9=B48=E6=9C=8820=E6=97=A5=E4=B8=8B=E5=
=8D=888:31=EF=BC=8CSimon Glass &lt;sjg@chromium.org&gt; =E5=86=99=E9=81=93=
=EF=BC=9A</div><div><br></div><div><br></div><div><div><div>Hi Valentin,</=
div><div><br></div><div>On 2026-08-18T17:53:00, Valentin Liu &lt;valentinl=
iu@icloud.com&gt; wrote:</div><blockquote type=3D"cite">boot: android: Add=
 Android 13+ bootflow support to bootmeth.</blockquote><div><br></div><div=
>Please drop the trailing period and keep the subject under 60 characters.=
</div><div><br></div><blockquote type=3D"cite"><div><br></div><div>The dev=
ices launching Android 13+ were using a new partition</div><div>named init=
_boot to store generic ramdisk.</div></blockquote><div><br></div><blockquo=
te type=3D"cite"><div><br></div><div>In the new bootflow, kernel still be =
stored in boot image,</div><div>however, the First Stage files in ramdisk =
were moved to</div><div>init_boot image. We should load it to memory and v=
erify it</div><div>so that the kernel can execute init program to continue=
 booting.</div><div><br></div><div>Currently, we have supported loading th=
e init_boot image by</div><div>abootimg command, but we still need bring t=
his ability to</div><div>bootmeth, so that booting Android 13+ will be mor=
e easily.</div></blockquote><div><br></div><div>Please use present/imperat=
ive tense throughout: 'were using' -&gt; 'use',</div><div>'kernel still be=
 stored' -&gt; 'the kernel is still stored', 'were moved'</div><div>-&gt; =
'are moved', 'we still need bring' -&gt; 'we still need to bring',</div><d=
iv>'more easily' -&gt; 'easier'.</div><div><br></div><blockquote type=3D"c=
ite"><div><br></div><div>In the new bootflow, kernel still be stored in bo=
ot image,</div><div>however, the First Stage files in ramdisk were moved t=
o</div><div>init_boot image. We should load it to memory and verify it</di=
v><div>so that the kernel can execute init program to continue booting.</d=
iv><div><br></div><div>Currently, we have supported loading the init_boot =
image by</div><div>abootimg command, but we still need bring this ability =
to</div><div>bootmeth, so that booting Android 13+ will be more easily.</d=
iv><div>Bootmeth will be able to recognize the new partition layout,</div>=
<div>and boot Android normally.</div><div><br></div><div>Link: <a href=3D"=
https://source.android.com/docs/core/architecture/partitions/generic-boot"=
 rel=3D"noopener noreferrer">https://source.android.com/docs/core/architec=
ture/partitions/generic-boot</a></div><div>Signed-off-by: Valentin Liu &lt=
;valentinliu@icloud.com&gt;</div><div><br></div><div>boot/bootmeth_android=
.c          | 67 ++++++++++++++++++++++++++++++++++++++++</div><div> boot/=
image-android.c             | 16 ++++++++++</div><div> cmd/abootimg.c     =
              |  5 +++</div><div> doc/develop/bootstd/overview.rst |  3 ++=
</div><div> include/android_image.h          |  1 +</div><div> include/ima=
ge.h                  | 35 +++++++++++++++++++++</div><div> 6 files change=
d, 127 insertions(+)</div></blockquote><div><br></div><div>Please can you =
look at how to add a test for this addition?</div><div><br></div><blockquo=
te type=3D"cite"><div>diff --git a/boot/bootmeth_android.c b/boot/bootmeth=
_android.c</div><div>@@ -113,6 +115,51 @@ static int scan_boot_part(struct=
 udevice *blk, struct android_priv *priv)</div><div>+static int scan_init_=
boot_part(struct udevice *blk, struct android_priv *priv)</div><div>+{</di=
v><div>+     struct blk_desc *desc =3D dev_get_uclass_plat(blk);</div><div=
>+     struct disk_partition partition;</div><div>+     char partname[PART=
_NAME_LEN];</div><div>+     ulong num_blks, bufsz;</div><div>+     char *b=
uf;</div><div>+     int ret;</div><div>+</div><div>+     if (priv-&gt;slot=
)</div><div>+             sprintf(partname, INIT_BOOT_PART_NAME "_%s", pri=
v-&gt;slot);</div><div>+     else</div><div>+             sprintf(partname=
, INIT_BOOT_PART_NAME);</div></blockquote><div><br></div><div>This is a ne=
ar-duplicate of scan_boot_part() and</div><div>scan_vendor_boot_part(). Pl=
ease factor the common logic (build</div><div>partname, read the header bl=
ock, check magic, extract size) into a</div><div>helper rather than adding=
 a third copy.</div><div><br></div><blockquote type=3D"cite"><div>diff --g=
it a/boot/bootmeth_android.c b/boot/bootmeth_android.c</div><div>@@ -291,6=
 +338,17 @@ static int android_read_bootflow(struct udevice *dev, struct b=
ootflow *bflow)</div><div>+     if (priv-&gt;header_version &gt;=3D 4) {</=
div><div>+             ret =3D scan_init_boot_part(bflow-&gt;blk, priv);</=
div><div>+             if (ret &lt; 0) {</div><div>+                     /=
*</div><div>+                      * Android 12 devices do not have the in=
it_boot partition.</div><div>+                      * Some devices upgrade=
d to Android 13 or later from</div><div>+                      * earlier A=
ndroid versions may also not have one.</div><div>+                      */=
</div><div>+                     log_debug("scan init_boot failed: err=3D%=
d\n", ret);</div><div>+             }</div><div>+     }</div></blockquote>=
<div><br></div><div>priv is allocated with plain malloc() above, so it is =
not zeroed. On</div><div>failure here priv-&gt;init_boot_img_size is left =
uninitialised, then</div><div>boot_android_normal() and (in patch 2) run_a=
vb_verification() read it</div><div>back as 'priv-&gt;init_boot_img_size &=
gt; 0'. Please use calloc()/memset(),</div><div>or explicitly set priv-&gt=
;init_boot_img_size =3D 0 before the call and on</div><div>the failure pat=
h.</div><div><br></div><blockquote type=3D"cite"><div>diff --git a/boot/bo=
otmeth_android.c b/boot/bootmeth_android.c</div><div>@@ -556,6 +614,7 @@ s=
tatic int boot_android_normal(struct bootflow *bflow)</div><div> ulong loa=
daddr =3D env_get_hex("loadaddr", 0);</div><div>+     ulong iloadaddr =3D =
env_get_hex("init_boot_comp_addr_r", 0);</div><div> ulong vloadaddr =3D en=
v_get_hex("vendor_boot_comp_addr_r", 0);</div></blockquote><div><br></div>=
<div>If init_boot_comp_addr_r is unset, env_get_hex() returns 0 and you</d=
iv><div>silently load init_boot at address 0 and call</div><div>set_ainit_=
bootimg_addr(0). Please check that iloadaddr is non-zero and</div><div>err=
or out with a clear message before using it - the vendor_boot path</div><d=
iv>has the same weakness, but let's not extend the pattern.</div><div><br>=
</div><blockquote type=3D"cite"><div>diff --git a/boot/image-android.c b/b=
oot/image-android.c</div><div>@@ -326,6 +326,22 @@ bool android_image_get_=
data(const void *boot_hdr, const void *vendor_boot_hdr,</div><div>+bool an=
droid_image_get_data_v4(const void *boot_hdr, const void *vendor_boot_hdr,=
</div><div>+                            const void *init_boot_hdr, struct =
andr_image_data *data)</div><div>+{</div><div>+     if (!android_image_get=
_data(boot_hdr, vendor_boot_hdr, data))</div><div>+             return fal=
se;</div><div>+</div><div>+     if (!is_android_boot_image_header(init_boo=
t_hdr)) {</div><div>+             printf("Incorrect init boot image header=
\n");</div><div>+             return false;</div><div>+     }</div><div>+<=
/div><div>+     android_boot_image_v3_v4_parse_hdr(init_boot_hdr, data);</=
div><div>+</div><div>+     return true;</div><div>+}</div></blockquote><di=
v><br></div><div>I can't find any caller of android_image_get_data_v4(). P=
lease either</div><div>wire it up to whatever consumes init_boot_img_total=
_size, or drop it</div><div>(and the new struct field, and the header decl=
aration) until it is</div><div>needed.</div><div><br></div><blockquote typ=
e=3D"cite"><div>diff --git a/include/image.h b/include/image.h</div><div>@=
@ -2167,6 +2184,17 @@ bool android_image_print_dtb_contents(ulong hdr_addr=
);</div><div>+/**</div><div>+ * is_android_init_boot_image_header() - Chec=
k the magic of init boot image</div><div>+ *</div><div>+ * This checks the=
 header of Android init boot image and verifies the</div><div>+ * magic is=
 "ANDROID!" (same with the boot image)</div><div>+ *</div><div>+ * @init_b=
oot_img: Pointer to boot image</div><div>+ * Return: non-zero if the magic=
 is correct, zero otherwise</div><div>+ */</div><div>+bool is_android_init=
_boot_image_header(const void *init_boot_img);</div></blockquote><div><br>=
</div><div>Declared but never defined or called - scan_init_boot_part() us=
es</div><div>is_android_boot_image_header() directly, which is correct sin=
ce the</div><div>magic is identical. Please drop the declaration.</div><di=
v><br></div><blockquote type=3D"cite"><div>diff --git a/include/image.h b/=
include/image.h</div><div>@@ -2199,6 +2227,13 @@ void set_abootimg_addr(ul=
ong addr);</div><div>+/**</div><div>+ * set_ainit_bootimg_addr() - Set And=
roid init boot image address</div><div>+ *</div><div>+ * Return: no return=
ed results</div><div>+ */</div><div>+void set_ainit_bootimg_addr(ulong add=
r);</div></blockquote><div><br></div><div>Missing @addr: description, and =
a void function does not need a</div><div>Return: line - please drop it.</=
div><div><br></div><blockquote type=3D"cite"><div>diff --git a/doc/develop=
/bootstd/overview.rst b/doc/develop/bootstd/overview.rst</div><div>@@ -293=
,6 +293,9 @@ script_offset_f</div><div>+init_boot_comp_addr_r</div><div>+ =
   Address to which to load the init_boot Android image, e.g. 0xd0000000</=
div></blockquote><div><br></div><div>Since this env var is required for An=
droid 13+ to boot, please also</div><div>document it in the relevant board=
 README(s) / sample env, and handle</div><div>the missing case gracefully =
in the code (see comment on</div><div>boot_android_normal()).</div><div><b=
r></div><div>Regards,</div><div>Simon</div></div></div></blockquote><div><=
br></div></body></html>
--Apple-Webmail-86--200cbcb5-fec1-46fd-a78b-64dee29fa0c9--

--Apple-Webmail-42--200cbcb5-fec1-46fd-a78b-64dee29fa0c9--

