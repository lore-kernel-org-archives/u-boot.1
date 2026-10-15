Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A6E2CC6B3A
	for <u-boot@archiver.kernel.org>; Thu, 15 Oct 2026 13:59:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5515381257;
	Thu, 15 Oct 2026 13:59:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5674AePzFwwG; Thu, 15 Oct 2026 13:59:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org B83A98123E
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792072793;
	b=V3zw488ypn7ZhK5crxC5eRPVkmTtUR3euxnsJ3RZKbfzmFzw6k5WKtIHe+j52sKHwytU
	 IzEMiau/skwVjW8xGHH5mU7qum7a8g0I6uhho6tobK2EVfIHB7k3N6FOpitKzEOoW9+sZ
	 SlXOpEPh71TGD9BccMrG4HRzFSXHwLbhBoHaRt7E8rJXY3HXZvRZ+rELE9je0Aoe2Yw9W
	 Vx0Pd1H7v4tdrX2vPExyMFRw94YwyjlqdcZylN1rePjmtcwLHg/SzqZN4yF+1G2gJPuYe
	 3d5yjq23jac8axykKHJ7mFTTpSaj+MJNSMH1gKygtyv2bh7OyKmz0qh8uuf7u5OlC0g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792072793;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:To:Cc:Subject:In-Reply-To:References:
	 Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=o12o47Lo9F09s+MPXWEHGl4cimC7EcEjOFpE5vSR8x4=;
	b=OdCnDKGk17fHdnCEd46RfeTZjZFKWWRnp6L+UGlk6B3JZpNYIeLkvwdwuLlHq9MA3OsD
	 satt1oE/jZ/3jm3meWURql8ovRhCyOLrtN6djpcTKTJWnLU6W0D/UyZCBt0o58z9gdCnX
	 CYjQtzDnvImm2yWimZ8MZ05qLToy0ScoVFbZJHt75xaGekOhBDzvaN2iMkCrmth5tOPGX
	 X+fUPxrdxQ314Tkoix87m8oC7r2DFFaStzkEBNDrIL/gI2CXGI1JdytBXDMj45MphhEVY
	 ZVNsNe4qyPwIOXDPentjMcKYGk4aFohgK+ARVo+G8WkwlPijm1ZoCPuRS81GsK9lg9w==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	dmarc=pass header.from=kernel.org;
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=d7fcLMto;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792072793;
	bh=o12o47Lo9F09s+MPXWEHGl4cimC7EcEjOFpE5vSR8x4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ClzJZS8La+Vxu5H8nRsMrrmwgh2m3Cr4JskWZfPq6IZAzqHlrB3LZzyyFT3j4gMSL
	 U1voqIiZ49bVLTtsYrv6330b/6akaqY0x6ftjsUDOraNzjIrqf/hED3m/R0CZg32ui
	 oGC4SfLldGwhllMSQLr57bpPR3tcZ8QIEkl27v44nJqkragZoKLCGxACidG6c7pWvr
	 n6eTdkd4sEJSc2IjH5doirKC8AMUdAhghIwmiQ0h760riAKaFotbYhLfBacIkOl1Hb
	 Ess+vmypzXd4o1IbIX9OBw7YAcxbJsJ3QRXf6H21iFHvnaIK/RD8ZhI2YELemSQOFM
	 VKNrCnCAQIA3g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id B83A98123E;
	Thu, 15 Oct 2026 13:59:53 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id B6C812E0
 for <u-boot@lists.u-boot-project.org>; Thu, 15 Oct 2026 13:59:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B0CA38123E
 for <u-boot@lists.u-boot-project.org>; Thu, 15 Oct 2026 13:59:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vM1g1irMMNIM for <u-boot@lists.u-boot-project.org>;
 Thu, 15 Oct 2026 13:59:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 2B3EC81227
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792072790;
 b=RlVvak5QJaz04ethvtv222zPruFqJX1SOou4FYZmShuaUmKN4YPkTnQ/EWBAiiNWP4j5
 m5b2r7tbRlb6eEQiljoMALeOZL5t5k9IOO4RLFB8XbuRRZbZs9x9L6oAmc0AslIebwpye
 wDa7XByK9RrZmlqL5fnVTascuJwY5ZDH4HlrXRfAJhNFoIvSEDTALgZ4MDcs15QU4AWIt
 6d8zmjG7li8srBeh2OkAzbjHVYTVX5IMz6hYdOSZka/4nOi/H4H3ZHNlrBwOb5oAe9Jfu
 AIW6K0JcgsDklWEonXKD1am2Ove/o2xYhcOm4qY4z1ZlnVZFdRcUO9230g7A9dmmQKA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792072790;
 h=Received-SPF:Received:Received:DKIM-Signature:From:To:Cc:Subject:
 In-Reply-To:References:Date:Message-ID:MIME-Version:Content-Type:
 Content-Transfer-Encoding;
 bh=o12o47Lo9F09s+MPXWEHGl4cimC7EcEjOFpE5vSR8x4=;
 b=NHC40jSBP+zygL8L0+05b2Xracj8i23L0KaTmnbietzfSziBSD5JDJrPnB4Pk5/bIo5H
 5xSLvOO/uNjz0NKRBKOiagJgH9+a5SXnW/wp/L4pfbMX46Jg7ImSzICjCMgb0Q9lUWZXY
 KwGSbLRpoJd8GusAgSxLwznrMyjtPRl8rogK1lhYK7QP+Q/fip6PrSnG9ogtF3ZLcc4nZ
 WF4C5UUu7s/wy/3vkvEN42xaPkTyE9qfZNVPGUfmO4qvwouPqs/f7IpJJ1YFo3lgTwjhO
 Bt5gTuJw2ln/bNxkXON1hiNzKTUPipw5D0iEaUwfoHjbd8fkoTQ4PWanNX1sGtmHfYw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=d7fcLMto; 
 arc=none smtp.remote-ip=172.234.252.31
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=mkorpershoek@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=d7fcLMto
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2B3EC81227
 for <u-boot@lists.u-boot-project.org>; Thu, 15 Oct 2026 13:59:49 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 1B86C43A14;
 Thu, 15 Oct 2026 13:59:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F2E51F000C5;
 Thu, 15 Oct 2026 13:59:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792072789;
 bh=o12o47Lo9F09s+MPXWEHGl4cimC7EcEjOFpE5vSR8x4=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date;
 b=d7fcLMtoaxakbYBMnmnzVyW9pvUPKFz5C7PvLlRc4oQoF7+2IQCSsRN+pO1FDJRIC
 wQfNPTHxRfHvVR21CKjWoC8S9DVYNcDZtQJBy9/NJdLiTcBSUUAnr50NohMF3TG59q
 qAf3HBoiaPT3PWUblzUgVrQPrR+zqHyfLT/wZ0VW9ypwq0ifixU9QzjF5YRIRauU8S
 yjO0WrPAhxbQWaekdekjjWYIPOGuCOj+jMKbgIRxykLAkiHqftlcJzW3ctRySsf6HJ
 /XwdUtIuQNISPD5W9icD0fLoHJ9MjuJ19+UOktx0iYO8NwJAVbHm3GxuWAa/23CnLI
 Jf1kW3GBEebFQ==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>, Jan Kehren
 <jan.kehren@emteria.com>
Cc: u-boot@lists.u-boot-project.org, igor.opaniuk@gmail.com,
 sjg@chromium.org, trini@konsulko.com
Subject: Re: [PATCH v2 2/2] avb: Take a storage interface in the AVB operations
In-Reply-To: <xhkdb8q407irr.fsf@mkorpers-koolstof.csb>
References: <20260915145629.995499-1-jan.kehren@emteria.com>
 <20261006092732.3577974-1-jan.kehren@emteria.com>
 <20261006092732.3577974-3-jan.kehren@emteria.com>
 <CAPzfCAah3xwR67hjz9Mi2E9CG-zcRj=Cdj8E55cH-0fiPA-XOw@mail.gmail.com>
 <xhkdbbj8w7mcn.fsf@mkorpers-koolstof.csb>
 <xhkdb8q407irr.fsf@mkorpers-koolstof.csb>
Date: Thu, 15 Oct 2026 15:59:46 +0200
Message-ID: <xhkdb5wz36p4d.fsf@mkorpers-koolstof.csb>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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

Hi Jan,

On Wed, Oct 14, 2026 at 11:07, Mattijs Korpershoek <mkorpershoek@kernel.org=
> wrote:

> On Wed, Oct 14, 2026 at 09:49, Mattijs Korpershoek <mkorpershoek@kernel.o=
rg> wrote:
>
>> Hi Igor, Jan,
>>
>> On Tue, Oct 13, 2026 at 17:31, Igor Opaniuk <igor.opaniuk@oss.qualcomm.c=
om> wrote:
>>
>>> Hi Jan,
>>>
>>> On Tue, Oct 6, 2026 at 3:00=E2=80=AFPM Jan Kehren <jan.kehren@emteria.c=
om> wrote:
>>>>
>>>> AVB assumed its partitions were on mmc: avb_ops_alloc() took a bare de=
vice
>>>> number and get_partition() called find_mmc_device(). bootmeth_android
>>>> accepts any bootdev but passes only desc->devnum, so an Android bootfl=
ow
>>>> found on nvme 0 or usb 0 is verified against mmc 0.
>>>
>>> I don't think this path can be reached today: android_check() rejects
>>> every non-mmc bootdev through bootflow_iter_check_mmc(), and
>>> android_read_bootflow() loads the BCB with
>>> bcb_find_partition_and_load("mmc", ...).
>>>
>>> So the bootmeth hunk below is right, but it does not change behaviour y=
et.
>>> The user that does benefit is "avb init <interface> <dev>", e.g.
>>> board/armltd/total_compute/total_compute.env, which has been calling
>>> "avb init ${blk_dev} 0" since 2024 and gets a usage error on next. Could
>>> you reword the motivation along those lines and mention total_compute?
>>>
>>>>
>>>> Carry a uclass id alongside the device number and resolve the block de=
vice
>>>> with blk_get_devnum_by_uclass_id(), keeping mmc_init() and the hardware
>>>> partition switch on the mmc path only. "avb init <dev>" still means mm=
c,
>>>> "avb init <interface> <dev>" selects another bus, and both now look the
>>>> device up before allocating. get_boot_interface() returns UCLASS_INVAL=
ID
>>>> without ops, so a caller that skipped "avb init" fails rather than rea=
ding
>>>> mmc.
>>>>
>>>> Signed-off-by: Jan Kehren <jan.kehren@emteria.com>
>>>> ---
>>>> Changes in v2:
>>>> - Split: the renames moved to the preceding patch
>>>> - Put the "avb init <dev>" comment on the branch it describes, by test=
ing
>>>>   argc =3D=3D 2 rather than argc =3D=3D 3
>>>> - Drop the single-use part_num and move the user-area comment next to
>>>>   mmc_switch_part()
>>>>
>>>>  boot/bootmeth_android.c                |  2 +-
>>>>  cmd/avb.c                              | 24 ++++++---
>>>>  common/Kconfig                         |  7 ++-
>>>>  common/avb_verify.c                    | 71 +++++++++++++++++---------
>>>>  doc/android/avb2.rst                   |  7 ++-
>>>>  include/avb_verify.h                   | 26 +++++++---
>>>>  test/py/tests/test_android/test_avb.py | 28 ++++++++++
>>>>  7 files changed, 127 insertions(+), 38 deletions(-)
>>>>
>>>> diff --git a/boot/bootmeth_android.c b/boot/bootmeth_android.c
>>>> index 0db08d4f86..ae05c08488 100644
>>>> --- a/boot/bootmeth_android.c
>>>> +++ b/boot/bootmeth_android.c
>>>> @@ -443,7 +443,7 @@ static int run_avb_verification(struct bootflow *b=
flow)
>>>>         bool unlocked =3D false;
>>>>         int ret;
>>>>
>>>> -       avb_ops =3D avb_ops_alloc(desc->devnum);
>>>> +       avb_ops =3D avb_ops_alloc(desc->uclass_id, desc->devnum);
>>>>         if (!avb_ops)
>>>>                 return log_msg_ret("avb ops", -ENOMEM);
>>>>
>>>> diff --git a/cmd/avb.c b/cmd/avb.c
>>>> index 8fbd48ee5a..4c1f56a33a 100644
>>>> --- a/cmd/avb.c
>>>> +++ b/cmd/avb.c
>>>> @@ -16,17 +16,28 @@ static struct AvbOps *avb_ops;
>>>>
>>>>  int do_avb_init(struct cmd_tbl *cmdtp, int flag, int argc, char *cons=
t argv[])
>>>>  {
>>>> -       unsigned long mmc_dev;
>>>> +       struct blk_desc *desc;
>>>>
>>>> -       if (argc !=3D 2)
>>>> +       if (argc < 2 || argc > 3)
>>>>                 return CMD_RET_USAGE;
>>>>
>>>> -       mmc_dev =3D hextoul(argv[1], NULL);
>>>> +       /* "avb init <dev>" keeps its old meaning of mmc <dev> */
>>>> +       if (argc =3D=3D 2)
>>>> +               desc =3D blk_get_devnum_by_uclass_id(UCLASS_MMC,
>>>> +                                                  hextoul(argv[1], NU=
LL));
>>>> +       else
>>>> +               desc =3D blk_get_devnum_by_uclass_idname(argv[1],
>>>> +                                                      hextoul(argv[2]=
, NULL));
>>>> +
>>>
>>> This up-front lookup is what breaks the existing sandbox tests: with the
>>> series, test_avb_verify, test_avb_read_rb, test_avb_is_unlocked,
>>> test_avb_persistent_values and the new test_avb_init_interface fail with
>>>
>>>   Can't map file 'mmc1.img': Invalid argument
>>>      sandbox_mmc_probe() mmc1: Unable to map file 'mmc1.img'
>>>   Can't find the requested device
>>>
>>> while next gives 4 passed, 2 skipped for test_avb.py.
>>>
>>> Sandbox mmc1 has no backing image when these tests run
>>> (test_android/ is collected before the tests that create mmc images),
>>> and most of them only talk to the sandbox TA, so they never needed
>>> the device before. Would you consider keeping
>>> "avb init" lazy: validate the interface name here, store uclass + numbe=
r,
>>> and let get_partition() resolve the device on first access as before?
>>>
>>> That keeps the old semantics, and a missing device is still reported, by
>>> the first partition access. Alternatively the tests would need to create
>>> mmc1.img first.
>>
>> Indeed, the sandbox tests fail on u-boot-dfu here:
>> https://git.u-boot-project.org/u-boot/custodians/u-boot-dfu/-/jobs/113402
>>
>> Before applying this series:
>> https://git.u-boot-project.org/u-boot/custodians/u-boot-dfu/-/jobs/113085
>>
>> I will have a look. I do have a preference for the mmc1.img to be
>> created in the tests first but I don't know if that's feasible.
>
> I've had a look. It's not impossible to do so, but the avb test as of
> today are buggy: some tests, such as test_avb_verify() use
> assert response.find(success_str) which is wrong.
>
> We should use 'assert response.find(success_str) !=3D -1'.
>
> I will send a fix for this, but that also requires modifying the tests
> and actually providing a valid mmc.img that contains a vbmeta partition
> and a boot partition.
>
> Since the above is not trivial, I'd like this patch to be reworked as
> Igor suggested.

I just send a series to fix the AVB pytests when running on sandbox
here:
https://lore.kernel.org/all/20261015-test-avb-fixes-v1-0-9e5b82644359@kerne=
l.org/

These might take some time to get reviewed. I've also tried to apply
your patches on top and they still work. The following fixup is needed:

commit ba6a82d93556bbb8599a87ab449276aa26ce4cdd
Author: Mattijs Korpershoek <mkorpershoek@kernel.org>
Date:   Thu Oct 15 15:08:08 2026 +0200

    fixup! avb: Take a storage interface in the AVB operations

diff --git a/test/py/tests/test_android/test_avb.py b/test/py/tests/test_an=
droid/test_avb.py
index edbe370ccec7..1687a170e30a 100644
--- a/test/py/tests/test_android/test_avb.py
+++ b/test/py/tests/test_android/test_avb.py
@@ -163,14 +163,14 @@ def test_avb_persistent_values(ubman, avb_device_id):
=20
 @pytest.mark.buildconfigspec('cmd_avb')
 @pytest.mark.buildconfigspec('cmd_mmc')
-def test_avb_init_interface(ubman):
+def test_avb_init_interface(ubman, avb_device_id):
     """Check that 'avb init' accepts an explicit interface
     """
=20
-    response =3D ubman.run_command('avb init mmc %s' % str(mmc_dev))
+    response =3D ubman.run_command('avb init mmc %x' % avb_device_id)
     assert response =3D=3D ''
=20
-    response =3D ubman.run_command('avb init %s' % str(mmc_dev))
+    response =3D ubman.run_command('avb init %x' % avb_device_id)
     assert response =3D=3D ''
=20

Since the current state is that your patches break CI, I will have to
drop them from my tree. I'm sorry about that.

Looking forward to v3.

Thanks
Mattijs

>
> Jan, can you please work on a v3 which keeps the old "lazy" init ?
>
> Please also address the other (valid) remarks from Igor and the same
> time.
>
> Thanks!
> Mattijs
>
>>
>> If I can't find a way for this, then we will have to rework this patch
>> as Igor suggested: (Keep the old behaviour: "lazy" init in "avb init")
>>
>>>
>>>
>>>> +       if (!desc) {
>>>> +               printf("Can't find the requested device\n");
>>>> +               return CMD_RET_FAILURE;
>>>> +       }
>>>>
>>>>         if (avb_ops)
>>>>                 avb_ops_free(avb_ops);
>>>>
>>>> -       avb_ops =3D avb_ops_alloc(mmc_dev);
>>>> +       avb_ops =3D avb_ops_alloc(desc->uclass_id, desc->devnum);
>>>>         if (avb_ops)
>>>>                 return CMD_RET_SUCCESS;
>>>>         else
>>>> @@ -428,7 +439,7 @@ int do_avb_write_pvalue(struct cmd_tbl *cmdtp, int=
 flag, int argc,
>>>>  }
>>>>
>>>>  static struct cmd_tbl cmd_avb[] =3D {
>>>> -       U_BOOT_CMD_MKENT(init, 2, 0, do_avb_init, "", ""),
>>>> +       U_BOOT_CMD_MKENT(init, 3, 0, do_avb_init, "", ""),
>>>>         U_BOOT_CMD_MKENT(read_rb, 2, 0, do_avb_read_rb, "", ""),
>>>>         U_BOOT_CMD_MKENT(write_rb, 3, 0, do_avb_write_rb, "", ""),
>>>>         U_BOOT_CMD_MKENT(is_unlocked, 1, 0, do_avb_is_unlocked, "", ""=
),
>>>> @@ -464,7 +475,8 @@ static int do_avb(struct cmd_tbl *cmdtp, int flag,=
 int argc, char *const argv[])
>>>>  U_BOOT_CMD(
>>>>         avb, 29, 0, do_avb,
>>>>         "Provides commands for testing Android Verified Boot 2.0 funct=
ionality",
>>>> -       "init <dev> - initialize avb2 for <dev>\n"
>>>> +       "init [<interface>] <dev> - initialize avb2 for hex <dev> on <=
interface>\n"
>>>> +       "    (mmc, nvme, usb, ...; defaults to mmc)\n"
>>>>         "avb read_rb <num> - read rollback index at location <num>\n"
>>>>         "avb write_rb <num> <rb> - write rollback index <rb> to <num>\=
n"
>>>>         "avb is_unlocked - returns unlock status of the device\n"
>>>> diff --git a/common/Kconfig b/common/Kconfig
>>>> index c739225621..5590fbfdb2 100644
>>>> --- a/common/Kconfig
>>>> +++ b/common/Kconfig
>>>> @@ -885,9 +885,14 @@ config AVB_VERIFY
>>>>           This option enables compilation of bootloader-dependent oper=
ations,
>>>>           used by Android Verified Boot 2.0 library (libavb). Includes:
>>>>           * Helpers to process strings in order to build OS bootargs.
>>>> -         * Helpers to access MMC, similar to drivers/fastboot/fb_mmc.=
c.
>>>> +         * Helpers to access block devices, similar to
>>>> +           drivers/fastboot/fb_mmc.c.
>>>>           * Helpers to alloc/init/free avb ops.
>>>>
>>>> +         Only mmc is initialised by AVB itself. Any other interface m=
ust
>>>> +         already be enumerated when AVB runs, either by the board cod=
e or by
>>>> +         a command such as "usb start".
>>>> +
>>>>  if AVB_VERIFY
>>>>
>>>>  config AVB_BUF_ADDR
>>>> diff --git a/common/avb_verify.c b/common/avb_verify.c
>>>> index fc29433c3c..b898ebb78f 100644
>>>> --- a/common/avb_verify.c
>>>> +++ b/common/avb_verify.c
>>>> @@ -8,6 +8,7 @@
>>>>  #include <cpu_func.h>
>>>>  #include <image.h>
>>>>  #include <malloc.h>
>>>> +#include <mmc.h>
>>>>  #include <part.h>
>>>>  #include <tee.h>
>>>>  #include <tee/optee_ta_avb.h>
>>>> @@ -386,44 +387,68 @@ static unsigned long avb_blk_write(struct avb_bl=
k_part *part, lbaint_t start,
>>>>                           start, sectors, tmp_buf);
>>>>  }
>>>>
>>>> -static struct avb_blk_part *get_partition(AvbOps *ops, const char *pa=
rtition)
>>>> +static int avb_init_mmc(int dev_num)
>>>>  {
>>>> +       struct mmc *mmc;
>>>>         int ret;
>>>> -       u8 dev_num;
>>>> -       int part_num =3D 0;
>>>> -       struct avb_blk_part *part;
>>>> -       struct blk_desc *blk;
>>>> -
>>>> -       part =3D malloc(sizeof(struct avb_blk_part));
>>>> -       if (!part)
>>>> -               return NULL;
>>>>
>>>> -       dev_num =3D get_boot_device(ops);
>>>> -       part->mmc =3D find_mmc_device(dev_num);
>>>> -       if (!part->mmc) {
>>>> +       mmc =3D find_mmc_device(dev_num);
>>>> +       if (!mmc) {
>>>>                 printf("%s: no MMC device at slot %x\n", __func__, dev=
_num);
>>>> -               goto err;
>>>> +               return -ENODEV;
>>>>         }
>>>>
>>>> -       ret =3D mmc_init(part->mmc);
>>>> +       ret =3D mmc_init(mmc);
>>>>         if (ret) {
>>>>                 printf("%s: MMC initialization failed, err =3D %d\n",
>>>>                        __func__, ret);
>>>> -               goto err;
>>>> +               return ret;
>>>>         }
>>>>
>>>> -       if (IS_MMC(part->mmc)) {
>>>> -               ret =3D mmc_switch_part(part->mmc, part_num);
>>>> +       if (IS_MMC(mmc)) {
>>>> +               /* Select the user area, where the GPT and our images =
live */
>>>> +               ret =3D mmc_switch_part(mmc, 0);
>>>>                 if (ret) {
>>>>                         printf("%s: MMC part switch failed, err =3D %d=
\n",
>>>>                                __func__, ret);
>>>> -                       goto err;
>>>> +                       return ret;
>>>>                 }
>>>>         }
>>>>
>>>> -       blk =3D mmc_get_blk_desc(part->mmc);
>>>> +       return 0;
>>>> +}
>>>> +
>>>> +static struct avb_blk_part *get_partition(AvbOps *ops, const char *pa=
rtition)
>>>> +{
>>>> +       enum uclass_id uclass_id;
>>>> +       struct avb_blk_part *part;
>>>> +       struct blk_desc *blk;
>>>> +       int dev_num;
>>>> +       int ret;
>>>> +
>>>> +       part =3D malloc(sizeof(struct avb_blk_part));
>>>> +       if (!part)
>>>> +               return NULL;
>>>> +
>>>> +       dev_num =3D get_boot_device(ops);
>>>> +       uclass_id =3D get_boot_interface(ops);
>>>> +       if (uclass_id =3D=3D UCLASS_INVALID || dev_num < 0) {
>>>> +               printf("%s: no storage interface, run 'avb init' first=
\n",
>>>> +                      __func__);
>>>> +               goto err;
>>>> +       }
>>>> +
>>>> +       if (uclass_id =3D=3D UCLASS_MMC) {
>>>> +               ret =3D avb_init_mmc(dev_num);
>>>> +               if (ret)
>>>> +                       goto err;
>>>> +       }
>>>> +
>>>> +       blk =3D blk_get_devnum_by_uclass_id(uclass_id, dev_num);
>>>>         if (!blk) {
>>>> -               printf("%s: failed to obtain block descriptor\n", __fu=
nc__);
>>>> +               /* Every bus but mmc must already be started when AVB =
runs */
>>>> +               printf("%s: no %s device %d, is the bus started?\n", _=
_func__,
>>>> +                      blk_get_uclass_name(uclass_id), dev_num);
>>>
>>> A note for the doc/Kconfig text rather than the code: with the images on
>>> virtio/NVMe/USB and the AVB TA keeping its state in eMMC RPMB, the TA's
>>> first RPMB request becomes the first eMMC access and happens from inside
>>> the supplicant RPC.
>>>
>>> On next that hangs: "avb init virtio 0; avb read_rb 0"
>>> leaves OP-TEE spinning in do_notif, the nested RPMB announcement deadlo=
ck
>>> fixed by "optee: do not announce RPMB from within a supplicant RPC"
>>> (currently v2 on the list). Not a bug in this series, but that
>>> configuration only works with that fix, so it may be worth a line in
>>> avb2.rst.
>>>
>>>>                 goto err;
>>>>         }
>>>>
>>>> @@ -433,7 +458,6 @@ static struct avb_blk_part *get_partition(AvbOps *=
ops, const char *partition)
>>>>                 goto err;
>>>>         }
>>>>
>>>> -       part->dev_num =3D dev_num;
>>>>         part->blk =3D blk;
>>>>
>>>>         return part;
>>>> @@ -1111,7 +1135,7 @@ __weak AvbIOResult avb_read_root_key_digest(AvbO=
ps *ops, uint8_t *digest)
>>>>   * AVB2.0 AvbOps alloc/initialisation/free
>>>>   * =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
>>>>   */
>>>> -AvbOps *avb_ops_alloc(int boot_device)
>>>> +AvbOps *avb_ops_alloc(enum uclass_id uclass_id, int dev_num)
>>>>  {
>>>>         struct AvbOpsData *ops_data;
>>>>
>>>> @@ -1134,7 +1158,8 @@ AvbOps *avb_ops_alloc(int boot_device)
>>>>         ops_data->ops.read_persistent_value =3D read_persistent_value;
>>>>  #endif
>>>>         ops_data->ops.get_size_of_partition =3D get_size_of_partition;
>>>> -       ops_data->mmc_dev =3D boot_device;
>>>> +       ops_data->uclass_id =3D uclass_id;
>>>> +       ops_data->dev_num =3D dev_num;
>>>>
>>>>         return &ops_data->ops;
>>>>  }
>>>> diff --git a/doc/android/avb2.rst b/doc/android/avb2.rst
>>>> index a514701241..cef49d3e0d 100644
>>>> --- a/doc/android/avb2.rst
>>>> +++ b/doc/android/avb2.rst
>>>> @@ -29,6 +29,10 @@ integration in ``common/avb_verify.c`` and the plat=
form port under
>>>>
>>>>  For additional details check [1]_.
>>>>
>>>> +Only mmc is started by AVB itself. Any other interface must already be
>>>> +enumerated when AVB runs, either by the board code or by a command su=
ch as
>>>> +``usb start``, or the partition lookup fails.
>>>> +
>>>>  AVB using OP-TEE (optional)
>>>>  ^^^^^^^^^^^^^^^^^^^^^^^^^^^
>>>>
>>>> @@ -80,7 +84,8 @@ AVB 2.0 U-Boot shell commands
>>>>  Provides CLI interface to invoke AVB 2.0 verification + misc. command=
s for
>>>>  different testing purposes::
>>>>
>>>> -    avb init <dev> - initialize avb 2 for <dev>
>>>> +    avb init [<interface>] <dev> - initialize avb 2 for hex <dev> on
>>>> +        <interface> (mmc, nvme, usb, ...; defaults to mmc)
>>>
>>> This is the behaviour change that bites, see the test comment at the en=
d:
>>> the lookup probes the device (blk_get_device() -> device_probe(), and f=
or
>>> mmc the blk probe runs mmc_init()), whereas "avb init" used to only sto=
re
>>> the number. Please at least state that it probes now.
>>>
>>>>      avb read_rb <num> - read rollback index at location <num>
>>>>      avb write_rb <num> <rb> - write rollback index <rb> to <num>
>>>>      avb is_unlocked - returns unlock status of the device
>>>> diff --git a/include/avb_verify.h b/include/avb_verify.h
>>>> index 8c97adbfbf..6dbbb39a8a 100644
>>>> --- a/include/avb_verify.h
>>>> +++ b/include/avb_verify.h
>>>> @@ -7,8 +7,9 @@
>>>>  #define _AVB_VERIFY_H
>>>>
>>>>  #include <../lib/libavb/libavb.h>
>>>> +#include <blk.h>
>>>>  #include <mapmem.h>
>>>> -#include <mmc.h>
>>>> +#include <part.h>
>>>>
>>>>  #define AVB_MAX_ARGS                   1024
>>>>  #define VERITY_TABLE_OPT_RESTART       "restart_on_corruption"
>>>> @@ -24,7 +25,8 @@ enum avb_boot_state {
>>>>
>>>>  struct AvbOpsData {
>>>>         struct AvbOps ops;
>>>> -       int mmc_dev;
>>>> +       enum uclass_id uclass_id;
>>>> +       int dev_num;
>>>>         enum avb_boot_state boot_state;
>>>>  #ifdef CONFIG_OPTEE_TA_AVB
>>>>         struct udevice *tee;
>>>> @@ -33,8 +35,6 @@ struct AvbOpsData {
>>>>  };
>>>>
>>>>  struct avb_blk_part {
>>>> -       int dev_num;
>>>> -       struct mmc *mmc;
>>>>         struct blk_desc *blk;
>>>>         struct disk_partition info;
>>>>  };
>>>> @@ -44,7 +44,7 @@ enum avb_io_type {
>>>>         AVB_IO_WRITE
>>>>  };
>>>>
>>>> -AvbOps *avb_ops_alloc(int boot_device);
>>>> +AvbOps *avb_ops_alloc(enum uclass_id uclass_id, int dev_num);
>>>>  void avb_ops_free(AvbOps *ops);
>>>>
>>>>  /**
>>>> @@ -110,10 +110,24 @@ static inline int get_boot_device(AvbOps *ops)
>>>>         if (ops) {
>>>>                 data =3D ops->user_data;
>>>>                 if (data)
>>>> -                       return data->mmc_dev;
>>>> +                       return data->dev_num;
>>>>         }
>>>>
>>>>         return -1;
>>>>  }
>>>>
>>>> +/* Mirrors get_boot_device(): no ops means no interface, not a defaul=
t one */
>>>> +static inline enum uclass_id get_boot_interface(AvbOps *ops)
>>>> +{
>>>> +       struct AvbOpsData *data;
>>>> +
>>>> +       if (ops) {
>>>> +               data =3D ops->user_data;
>>>> +               if (data)
>>>> +                       return data->uclass_id;
>>>> +       }
>>>> +
>>>> +       return UCLASS_INVALID;
>>>> +}
>>>> +
>>>>  #endif /* _AVB_VERIFY_H */
>>>> diff --git a/test/py/tests/test_android/test_avb.py b/test/py/tests/te=
st_android/test_avb.py
>>>> index 137d83e1de..4c5b3c6f59 100644
>>>> --- a/test/py/tests/test_android/test_avb.py
>>>> +++ b/test/py/tests/test_android/test_avb.py
>>>> @@ -135,3 +135,31 @@ def test_avb_persistent_values(ubman):
>>>>
>>>>      response =3D ubman.run_command('avb read_pvalue test 12')
>>>>      assert response =3D=3D 'Read 12 bytes, value =3D value_value'
>>>> +
>>>> +
>>>> +@pytest.mark.buildconfigspec('cmd_avb')
>>>> +@pytest.mark.buildconfigspec('cmd_mmc')
>>>> +def test_avb_init_interface(ubman):
>>>> +    """Check that 'avb init' accepts an explicit interface
>>>> +    """
>>>> +
>>>> +    response =3D ubman.run_command('avb init mmc %s' % str(mmc_dev))
>>>> +    assert response =3D=3D ''
>>>
>>> Fails on sandbox for the same mmc1.img reason, see above.
>>>
>>> With the "avb init" behaviour sorted out, the rest works for me:
>>> * "avb init 0" as the first eMMC access, read_rb, is_unlocked and
>>>   "avb verify _a" pass;
>>> * "avb init nvme 0", "avb init mmc 5" and "avb init bogus 0" fail clean=
ly;
>>> * with the Android images on virtio only (the eMMC holding just RPMB),
>>>   "avb init virtio 0; avb verify _a" passes, and "avb init 0" on the
>>>   empty eMMC correctly fails to find vbmeta_a;
>>>
>>>> +
>>>> +    response =3D ubman.run_command('avb init %s' % str(mmc_dev))
>>>> +    assert response =3D=3D ''
>>>> +
>>>> +
>>>> +@pytest.mark.buildconfigspec('cmd_avb')
>>>> +def test_avb_init_bad_device(ubman):
>>>> +    """Check that 'avb init' rejects a device that does not exist
>>>> +    """
>>>> +
>>>> +    response =3D ubman.run_command('avb init mmc ff')
>>>> +    assert response.find("Can't find the requested device") !=3D -1
>>>> +
>>>> +    response =3D ubman.run_command('avb init ff')
>>>> +    assert response.find("Can't find the requested device") !=3D -1
>>>> +
>>>> +    response =3D ubman.run_command('avb init nonsense 0')
>>>> +    assert response.find("Can't find the requested device") !=3D -1
>>>> --
>>>> 2.43.0
>>>>
