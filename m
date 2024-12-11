Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4690CE7717F
	for <u-boot@archiver.kernel.org>; Thu, 12 Dec 2024 13:14:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6C3D08020D;
	Thu, 12 Dec 2024 14:14:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=aurora.tech
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=aurora.tech header.i=@aurora.tech header.b="XhotH+7n";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5A344801DD; Wed, 11 Dec 2024 23:28:51 +0100 (CET)
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com
 [IPv6:2607:f8b0:4864:20::22a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4E4B880192
 for <u-boot@lists.denx.de>; Wed, 11 Dec 2024 23:28:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=aurora.tech
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jdanisevskis@aurora.tech
Received: by mail-oi1-x22a.google.com with SMTP id
 5614622812f47-3eb569ec0d9so1114611b6e.1
 for <u-boot@lists.denx.de>; Wed, 11 Dec 2024 14:28:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=aurora.tech; s=google; t=1733956126; x=1734560926; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=DDnxmdiJ763/jmlUYwtKa4iNBVYUayzDBOfWzWZHhio=;
 b=XhotH+7nSdDHgyzsQI4gG6ONnXZb6/l/eKfD7eZ4C6dR14gEqkpb/oYNT5msWq4kma
 82diQKCU2ZrsC6cvMUoVGqcV1u0ainM5WiMrSuOJUCECixhNu043t+1Ds8VIvPi0i9YC
 QVcIbhZWCDjTuiS+/VtBjsLeAFwpuWEMVEGUmzbFCpu/ltnFlpKk7C+5bqIbRWfQ/mUq
 +pJrKkf0bwWEReCUxc7ux/jxzvHEnBrMeI20ppW+nMeOyPLWOHoZlD86ZepkeVPSTbR5
 Yw0LJwQgfQeCOyA0DtGiGj1ppeaOXO4oAgvvlFSszycBst8droe7Z9qx0SiFV80rFsVC
 lzpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733956126; x=1734560926;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DDnxmdiJ763/jmlUYwtKa4iNBVYUayzDBOfWzWZHhio=;
 b=hJcUm3CEahNnBdv3WxW2YBjQJHsbwSzfYX6iHd8lzer6G+v3cuqj9ol1L0r6K/1S86
 VKM62jzgsHsCJ3LwiQNqpHKA+zVijb2iqC9hCa7OfYT2NmW0Rf+wadvNSUjx9cr2ISXD
 nnh0Yy0QADUvrRzohHLVvMAgGY3QtAbNYd39ZRBADG8PEyN82NcBhq1i+fqxYHl1S+/N
 CjAPkdJKBPFZqYWUtsJp5B28lGX5Y0lGIwGDlC0YGgsUvyPsj6QEnQog10uELl0jtUt+
 NgoisLucl942fw7d7Jy9N1WRCYqLy2ML0Ic3OocKWw0ZOi+2Li/YoIZCpkk+RIG0kAXb
 pLeA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXXZNnOfBD1dWT4c3KBtc79tIBcdYYq+utwUDB8WxMCekcB3Jm+PkiI4/PIMv5OrQGKMccsgvc=@lists.denx.de
X-Gm-Message-State: AOJu0YwaTXuWeNhoob66gmwG995g9ByBVBrg8+S9Cv0gxVxZg3mVSqVS
 t/3JicUAHoU3G/bmqtPLiiCfeVIaPU5h0fQ7z/8VbsADyJJuw8OmGSlahscV6UPiecvAuqVXn0S
 YPZFidQLbqf4NdFCtIc7HY4R9YhO4jf0nb35AKA==
X-Gm-Gg: ASbGncun6LUVnmRt8g75RVk+JgfeKMonIANK97jtDmy19WCAfK1qs+oBQ/k10TFFnMv
 MJnKM01pZNYu+yw0+/TpSSy09MT+7DoJZ
X-Google-Smtp-Source: AGHT+IHbwX1R5VqDFvfmO19XL2uHzxrl08hByhmGy5lfWEWWCOxzRIkaJKWHL4rHIWsGbmtOo/MNfFN2Xlo+L8B/uhY=
X-Received: by 2002:a05:6870:d6a5:b0:29e:2ce2:94d with SMTP id
 586e51a60fabf-2a012db1077mr2246147fac.14.1733956125937; Wed, 11 Dec 2024
 14:28:45 -0800 (PST)
MIME-Version: 1.0
References: <20241123195616.305687-1-mjg59@srcf.ucam.org>
 <20241123195616.305687-10-mjg59@srcf.ucam.org>
 <1a9d7b81-b06f-43bd-969e-2961ad8cd1e0@gmx.de>
 <CAFLszThHxSt7-8QScz8+d96PwrZy--MKYsnrhfdCw8TK0c8rLA@mail.gmail.com>
 <20241210171113.GD2457179@bill-the-cat>
 <CAFBqBq9-wrpXnz99TNNokjMqbzz0fJPq+UUMqhuuMqZwmjSH=Q@mail.gmail.com>
 <CAFLszTiD21ut+i1ob3sWCMtWF8ccXvhj2c306DDamz06EmpQmQ@mail.gmail.com>
In-Reply-To: <CAFLszTiD21ut+i1ob3sWCMtWF8ccXvhj2c306DDamz06EmpQmQ@mail.gmail.com>
From: Janis Danisevskis <jdanisevskis@aurora.tech>
Date: Wed, 11 Dec 2024 14:28:35 -0800
Message-ID: <CAFBqBq9ZHRGRcQULo2mkQ8cY3uB419dmAtbSF8QNvxegSAVYTQ@mail.gmail.com>
Subject: Re: [PATCH 09/10] Fix efi_bind_block.
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Matthew Garrett <mjg59@srcf.ucam.org>,
 Matthew Garrett <mgarrett@aurora.tech>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de
Content-Type: multipart/mixed; boundary="000000000000f1a2e60629061e28"
X-Mailman-Approved-At: Thu, 12 Dec 2024 14:14:07 +0100
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

--000000000000f1a2e60629061e28
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Here is an updated version of the patch.

Please bear with me while I learn this email based code review process.
I am trying to find resources on this, but there are a lot and I don't know
what applies here.

Anyway, I believe there was another leak. If the call to device_bind fails
both plat and plat->device_path need to be freed.
I think I captured this in the new version.

The other open issue was the duplication of efi_dp_size code. But if I
understand correctly
this was not available in the configuration that we are using. Not sure
what the path forward should be here.

With kind regards,
Janis

On Wed, Dec 11, 2024 at 12:23=E2=80=AFPM Simon Glass <sjg@chromium.org> wro=
te:

> Hi Janis,
>
> On Wed, 11 Dec 2024 at 10:50, Janis Danisevskis
> <jdanisevskis@aurora.tech> wrote:
> >
> > Hi everyone,
> >
> > Good catch finding this leak. Would you like me to provide an updated
> patch?
> > I am good either way. Let Simon take credit for the fix on the git
> history. I can live with
> > shame :-).
>
> Thanks for the email. If you're able to send a v2, take a look at this
> series which has a few other things:
>
> https://patchwork.ozlabs.org/project/uboot/list/?series=3D436150
>
> You can incorporate any or all of those and there's no need to keep me
> as the author of anything in particular.
>
> Regards,
> Simon
>
>
> >
> > Janis
> >
> > On Tue, Dec 10, 2024 at 9:11=E2=80=AFAM Tom Rini <trini@konsulko.com> w=
rote:
> >>
> >> On Tue, Dec 10, 2024 at 09:17:26AM -0700, Simon Glass wrote:
> >> > Hi Heinrich,
> >> >
> >> > On Tue, 10 Dec 2024 at 01:50, Heinrich Schuchardt <xypron.glpk@gmx.d=
e>
> wrote:
> >> > >
> >> > > On 23.11.24 20:55, Matthew Garrett wrote:
> >> > > > From: Janis Danisevskis <jdanisevskis@aurora.tech>
> >> > > >
> >> > > > efi_bind_block had two issues.
> >> > > > 1. A pointer to a the stack was inserted as plat structure and
> thus used
> >> > > > beyond its life time.
> >> > > > 2. Only the first segment of the device path was copied into the
> >> > > > platfom data structure resulting in an unterminated device path.
> >> > > >
> >> > > > Signed-off-by: Janis Danisevskis <jdanisevskis@aurora.tech>
> >> > > > Signed-off-by: Matthew Garrett <mgarrett@aurora.tech>
> >> > > > ---
> >> > > >
> >> > > >   lib/efi/efi_app_init.c | 29 +++++++++++++++++++++--------
> >> > > >   1 file changed, 21 insertions(+), 8 deletions(-)
> >> > > >
> >> > > > diff --git a/lib/efi/efi_app_init.c b/lib/efi/efi_app_init.c
> >> > > > index 9704020b749..cc91e1d74b8 100644
> >> > > > --- a/lib/efi/efi_app_init.c
> >> > > > +++ b/lib/efi/efi_app_init.c
> >> > > > @@ -19,6 +19,15 @@
> >> > > >
> >> > > >   DECLARE_GLOBAL_DATA_PTR;
> >> > > >
> >> > > > +static size_t device_path_length(const struct efi_device_path
> *device_path)
> >> > > > +{
> >> > > > +     const struct efi_device_path *d;
> >> > > > +
> >> > > > +     for (d =3D device_path; d->type !=3D DEVICE_PATH_TYPE_END;=
 d =3D
> (void *)d + d->length) {
> >> > > > +     }
> >> > > > +     return (void *)d - (void *)device_path + d->length;
> >> > > > +}
> >> > > > +
> >> > > >   /**
> >> > > >    * efi_bind_block() - bind a new block device to an EFI device
> >> > > >    *
> >> > > > @@ -39,19 +48,23 @@ int efi_bind_block(efi_handle_t handle,
> struct efi_block_io *blkio,
> >> > > >                  struct efi_device_path *device_path, int len,
> >> > > >                  struct udevice **devp)
> >> > > >   {
> >> > > > -     struct efi_media_plat plat;
> >> > > > +     struct efi_media_plat *plat;
> >> > > >       struct udevice *dev;
> >> > > >       char name[18];
> >> > > >       int ret;
> >> > > > -
> >> > > > -     plat.handle =3D handle;
> >> > > > -     plat.blkio =3D blkio;
> >> > > > -     plat.device_path =3D malloc(device_path->length);
> >> > > > -     if (!plat.device_path)
> >> > > > +     size_t device_path_len =3D device_path_length(device_path)=
;
> >> > > > +
> >> > > > +     plat =3D malloc(sizeof(struct efi_media_plat));
> >> > > > +     if (!plat)
> >> > > > +             return log_msg_ret("plat", -ENOMEM);
> >> > > > +     plat->handle =3D handle;
> >> > > > +     plat->blkio =3D blkio;
> >> > > > +     plat->device_path =3D malloc(device_path_len);
> >> > > > +     if (!plat->device_path)
> >> > > >               return log_msg_ret("path", -ENOMEM);
> >> > > > -     memcpy(plat.device_path, device_path, device_path->length)=
;
> >> > > > +     memcpy(plat->device_path, device_path, device_path_len);
> >> > > >       ret =3D device_bind(dm_root(), DM_DRIVER_GET(efi_media),
> "efi_media",
> >> > > > -                       &plat, ofnode_null(), &dev);
> >> > > > +                       plat, ofnode_null(), &dev);
> >> > > >       if (ret)
> >> > > >               return log_msg_ret("bind", ret);
> >> > >
> >> > > Here you have a memory leak for pointer plat if ret !=3D 0.
> >> > >
> >> > > Simon suggested a follow up patch. Instead we should fix it in thi=
s
> patch.
> >> > >
> >> > > @Simon
> >> > > The logic in the caller setup_block() looks wrong.
> >> > >
> >> > > LocateHandle() does not ensure that when you try to read from the
> block
> >> > > device the same still does exist. E.g. if a USB device is removed
> the
> >> > > block IO protocol could be uninstalled and the handle deleted and
> the
> >> > > EFI app may crash. Please, call OpenProtocol() with attribute
> BY_DRIVER.
> >> > >
> >> > > HandleProtocol() is considered deprecated. Please, use
> OpenProtocol()
> >> > > instead.
> >> >
> >> > Can you please send a follow-up with your ideas on this?
> >>
> >> Simon, it's in your tree. The normal path here would be that the
> >> submitter would correct this in v2. But you're trying to short-circuit
> >> that path for your own reasons. No one should be making work on top of
> >> your tree except for you.
> >>
> >> --
> >> Tom
>

--000000000000f1a2e60629061e28
Content-Type: application/x-patch; name="0001-Fix-efi_bind_block.patch"
Content-Disposition: attachment; filename="0001-Fix-efi_bind_block.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_m4kgav750>
X-Attachment-Id: f_m4kgav750

RnJvbSA4OTU2ZDZkMmFkYWQzNjEyM2RmNjhhOTM2MDRmMTliMzhiN2ZhOGU3IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBKYW5pcyBEYW5pc2V2c2tpcyA8amRhbmlzZXZza2lzQGF1cm9y
YS50ZWNoPgpEYXRlOiBTYXQsIDIzIE5vdiAyMDI0IDExOjU1OjA4IC0wODAwClN1YmplY3Q6IFtQ
QVRDSF0gRml4IGVmaV9iaW5kX2Jsb2NrLgoKZWZpX2JpbmRfYmxvY2sgaGFkIHR3byBpc3N1ZXMu
CjEuIEEgcG9pbnRlciB0byBhIHRoZSBzdGFjayB3YXMgaW5zZXJ0ZWQgYXMgcGxhdCBzdHJ1Y3R1
cmUgYW5kIHRodXMgdXNlZApiZXlvbmQgaXRzIGxpZmUgdGltZS4KMi4gT25seSB0aGUgZmlyc3Qg
c2VnbWVudCBvZiB0aGUgZGV2aWNlIHBhdGggd2FzIGNvcGllZCBpbnRvIHRoZQpwbGF0Zm9tIGRh
dGEgc3RydWN0dXJlIHJlc3VsdGluZyBpbiBhbiB1bnRlcm1pbmF0ZWQgZGV2aWNlIHBhdGguCgpT
aWduZWQtb2ZmLWJ5OiBKYW5pcyBEYW5pc2V2c2tpcyA8amRhbmlzZXZza2lzQGF1cm9yYS50ZWNo
PgpTaWduZWQtb2ZmLWJ5OiBNYXR0aGV3IEdhcnJldHQgPG1nYXJyZXR0QGF1cm9yYS50ZWNoPgot
LS0KIGxpYi9lZmkvZWZpX2FwcF9pbml0LmMgfCA1MyArKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKy0tLS0tLS0tLS0KIDEgZmlsZSBjaGFuZ2VkLCA0MSBpbnNlcnRpb25zKCspLCAxMiBk
ZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9saWIvZWZpL2VmaV9hcHBfaW5pdC5jIGIvbGliL2Vm
aS9lZmlfYXBwX2luaXQuYwppbmRleCA5NzA0MDIwYjc0OS4uZjNiYTgyMjgwZjQgMTAwNjQ0Ci0t
LSBhL2xpYi9lZmkvZWZpX2FwcF9pbml0LmMKKysrIGIvbGliL2VmaS9lZmlfYXBwX2luaXQuYwpA
QCAtMTksNiArMTksMTUgQEAKIAogREVDTEFSRV9HTE9CQUxfREFUQV9QVFI7CiAKK3N0YXRpYyBz
aXplX3QgZGV2aWNlX3BhdGhfbGVuZ3RoKGNvbnN0IHN0cnVjdCBlZmlfZGV2aWNlX3BhdGggKmRl
dmljZV9wYXRoKQoreworCWNvbnN0IHN0cnVjdCBlZmlfZGV2aWNlX3BhdGggKmQ7CisKKwlmb3Ig
KGQgPSBkZXZpY2VfcGF0aDsgZC0+dHlwZSAhPSBERVZJQ0VfUEFUSF9UWVBFX0VORDsgZCA9ICh2
b2lkICopZCArIGQtPmxlbmd0aCkgeworCX0KKwlyZXR1cm4gKHZvaWQgKilkIC0gKHZvaWQgKilk
ZXZpY2VfcGF0aCArIGQtPmxlbmd0aDsKK30KKwogLyoqCiAgKiBlZmlfYmluZF9ibG9jaygpIC0g
YmluZCBhIG5ldyBibG9jayBkZXZpY2UgdG8gYW4gRUZJIGRldmljZQogICoKQEAgLTM5LDI3ICs0
OCw0NyBAQCBpbnQgZWZpX2JpbmRfYmxvY2soZWZpX2hhbmRsZV90IGhhbmRsZSwgc3RydWN0IGVm
aV9ibG9ja19pbyAqYmxraW8sCiAJCSAgIHN0cnVjdCBlZmlfZGV2aWNlX3BhdGggKmRldmljZV9w
YXRoLCBpbnQgbGVuLAogCQkgICBzdHJ1Y3QgdWRldmljZSAqKmRldnApCiB7Ci0Jc3RydWN0IGVm
aV9tZWRpYV9wbGF0IHBsYXQ7CisJc3RydWN0IGVmaV9tZWRpYV9wbGF0ICpwbGF0ID0gTlVMTDsK
IAlzdHJ1Y3QgdWRldmljZSAqZGV2OwogCWNoYXIgbmFtZVsxOF07Ci0JaW50IHJldDsKLQotCXBs
YXQuaGFuZGxlID0gaGFuZGxlOwotCXBsYXQuYmxraW8gPSBibGtpbzsKLQlwbGF0LmRldmljZV9w
YXRoID0gbWFsbG9jKGRldmljZV9wYXRoLT5sZW5ndGgpOwotCWlmICghcGxhdC5kZXZpY2VfcGF0
aCkKLQkJcmV0dXJuIGxvZ19tc2dfcmV0KCJwYXRoIiwgLUVOT01FTSk7Ci0JbWVtY3B5KHBsYXQu
ZGV2aWNlX3BhdGgsIGRldmljZV9wYXRoLCBkZXZpY2VfcGF0aC0+bGVuZ3RoKTsKKwlpbnQgcmV0
LCBlcnI7CisJc2l6ZV90IGRldmljZV9wYXRoX2xlbiA9IGRldmljZV9wYXRoX2xlbmd0aChkZXZp
Y2VfcGF0aCk7CisKKwlwbGF0ID0gbWFsbG9jKHNpemVvZihzdHJ1Y3QgZWZpX21lZGlhX3BsYXQp
KTsKKwlpZiAoIXBsYXQpIHsKKwkJcmV0dXJuIGxvZ19tc2dfcmV0KCJwbGF0IiwgLUVOT01FTSk7
CisJfQorCXBsYXQtPmhhbmRsZSA9IGhhbmRsZTsKKwlwbGF0LT5ibGtpbyA9IGJsa2lvOworCXBs
YXQtPmRldmljZV9wYXRoID0gbWFsbG9jKGRldmljZV9wYXRoX2xlbik7CisJaWYgKCFwbGF0LT5k
ZXZpY2VfcGF0aCkgeworCQllcnIgPSBsb2dfbXNnX3JldCgicGF0aCIsIC1FTk9NRU0pOworCQln
b3RvIGVycl9vdXQ7CisJfQorCW1lbWNweShwbGF0LT5kZXZpY2VfcGF0aCwgZGV2aWNlX3BhdGgs
IGRldmljZV9wYXRoX2xlbik7CiAJcmV0ID0gZGV2aWNlX2JpbmQoZG1fcm9vdCgpLCBETV9EUklW
RVJfR0VUKGVmaV9tZWRpYSksICJlZmlfbWVkaWEiLAotCQkJICAmcGxhdCwgb2Zub2RlX251bGwo
KSwgJmRldik7Ci0JaWYgKHJldCkKLQkJcmV0dXJuIGxvZ19tc2dfcmV0KCJiaW5kIiwgcmV0KTsK
KwkJCSAgcGxhdCwgb2Zub2RlX251bGwoKSwgJmRldik7CisJaWYgKHJldCkgeworCQllcnIgPSBs
b2dfbXNnX3JldCgiYmluZCIsIHJldCk7CisJCWdvdG8gZXJyX291dDsKKwl9CiAKIAlzbnByaW50
ZihuYW1lLCBzaXplb2YobmFtZSksICJlZmlfbWVkaWFfJXgiLCBkZXZfc2VxKGRldikpOwogCWRl
dmljZV9zZXRfbmFtZShkZXYsIG5hbWUpOwogCSpkZXZwID0gZGV2OwogCiAJcmV0dXJuIDA7CisK
K2Vycl9vdXQ6CisJaWYgKHBsYXQpIHsKKwkJLy8gSWYgcGxhdCBpcyBub3QgTlVMTCwgcGxhdC0+
ZGV2aWNlX3BhdGgKKwkJLy8gaXMgdGhlIHJldHVybiB2YWx1ZSBvZiBtYWxsb2MuIFNvIGl0IGlz
CisJCS8vIGVpdGhlciBOVUxMIG9yIGEgdmFsaWQgcG9pbnRlciB0aGF0IG5lZWRzCisJCS8vIHRv
IGJlIGZyZWVkLgorCQlmcmVlKHBsYXQtPmRldmljZV9wYXRoKTsKKwl9CisJZnJlZShwbGF0KTsK
KwlyZXR1cm4gZXJyOwogfQogCiAvKioKLS0gCjIuMzQuMQoK
--000000000000f1a2e60629061e28--
