Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36889CD4F24
	for <u-boot@archiver.kernel.org>; Wed, 13 May 2026 12:09:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 84DE384099;
	Wed, 13 May 2026 14:09:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="dxFSA2yG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 96C11844BF; Wed, 13 May 2026 14:09:48 +0200 (CEST)
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E060C836AC
 for <u-boot@lists.denx.de>; Wed, 13 May 2026 14:09:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id B8CC8600CB;
 Wed, 13 May 2026 12:09:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC8E2C2BCB7;
 Wed, 13 May 2026 12:09:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1778674184;
 bh=whriFQ/Uo1oYXMQpgqULk5lFViG0EOzyB2DukkmRVuo=;
 h=From:To:Subject:In-Reply-To:References:Date:From;
 b=dxFSA2yGcsFDhj88FhpyN7hsI6OHq06Z4SGuTBId+el3igR4l5UrFuCE31e14KmFy
 6N/c1bguqvr+v8XOwTPa20uDLZHMGZAP+PaSAfsMIgNOawJm55Yw+Sw5M/Fo0xLnOq
 1DuKZh/tH32NZki2o+1myuoxhxp9TLE+id5WKiZl+YIQtOrHg1wkzkhRfGTApwHT00
 euuKVXlr1d5fwK2EzJbI55/mHpoB6xqG21ZkGYX3blL9vPDr+AA0v2+CMudLkX4jp6
 7TXAKPkLTwAmTKxfo/Qu2pFGHa1REdFV03nQ3biJwr/gHR71/YjxmOPZ0nzgyOsVPZ
 VN1c2/mFRZD9w==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: "Pinnell McAllister, Colin" <Colin.McAllister@garmin.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: Re: [PATCH] android_ab: fix slot selection
In-Reply-To: <PH7PR04MB8731B036A282B4DC1644B052F4582@PH7PR04MB8731.namprd04.prod.outlook.com>
References: <20260313201415.255744-1-colin.mcallister@garmin.com>
 <87zf3ccu3l.fsf@kernel.org>
 <PH7PR04MB8731B036A282B4DC1644B052F4582@PH7PR04MB8731.namprd04.prod.outlook.com>
Date: Wed, 13 May 2026 14:09:41 +0200
Message-ID: <878q9nv7cq.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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

Hi Colin,

On Thu, Apr 09, 2026 at 15:34, "Pinnell McAllister, Colin" <Colin.McAlliste=
r@garmin.com> wrote:

> Hi Mattijs,
>
> Thank you for the response! This wasn't a critical change, so no worries =
about the delay.
>
> Outlook is kind of terrible for replying inline...I should have used my g=
mail account for this patch. My responses to you message are below.

I agree that Outlook is not very good here.
I can't seem to be able to apply the patch:

$ b4 shazam -s -l --check 20260313201415.255744-1-colin.mcallister@garmin.c=
om
Looking up 20260313201415.255744-1-colin.mcallister@garmin.com
Checking for newer revisions
Grabbing search results from lore.kernel.org
Analyzing 3 messages in the thread
Looking for additional code-review trailers on lore.kernel.org
Analyzing 0 code-review messages
Checking attestation on all messages, may take a moment...
Retrieving patchwork CI status, may take a moment...
---
  =E2=9C=93 [PATCH] android_ab: fix slot selection
    + Link: https://patch.msgid.link/20260313201415.255744-1-colin.mcallist=
er@garmin.com
    + Signed-off-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
    =E2=97=8F checkpatch.pl: 196: ERROR: code indent should use tabs where =
possible
    =E2=97=8F checkpatch.pl: 196: WARNING: please, no spaces at the start o=
f a line
    =E2=97=8F checkpatch.pl: 197: ERROR: code indent should use tabs where =
possible
    =E2=97=8F checkpatch.pl: 197: WARNING: please, no spaces at the start o=
f a line
    =E2=97=8F checkpatch.pl: 201: ERROR: code indent should use tabs where =
possible
    =E2=97=8F checkpatch.pl: 201: WARNING: please, no spaces at the start o=
f a line
    =E2=97=8F checkpatch.pl: 203: ERROR: code indent should use tabs where =
possible
    =E2=97=8F checkpatch.pl: 203: WARNING: please, no spaces at the start o=
f a line
    =E2=97=8F checkpatch.pl: 204: ERROR: code indent should use tabs where =
possible
    =E2=97=8F checkpatch.pl: 204: WARNING: please, no spaces at the start o=
f a line
  ---
  =E2=9C=93 Signed: DKIM/garmin.com
---
Total patches: 1

Can you resend it?
More information below.

>
>> Please use ./scripts/get_maintainer.pl -f boot/android_ab.c next time yo=
u send a patch.
>
> ack
>
>> Can you please give me more references to the boot selection rules?
>> Is this just the code comment that's mentioned (boot/android_ab.c:276) ?
>
> Yes, that is correct. I do not have any other references to cite.
>
>> It seems to be using libboot_control as a static library.
>> libboot_control tells us that a slot is considered unbootable when:
>> tries_remaining !=3D 0;
>
> I also see that tries_remaining is set to 1 on successful boot:
> https://cs.android.com/android/platform/superproject/+/android-latest-rel=
ease:hardware/interfaces/boot/1.1/default/boot_control/libboot_control.cpp;=
l=3D260?q=3Dlibboot_control
>
> This is what we also currently do when marking a boot as successful. Howe=
ver, it is unclear if this is a requirement in the spec and what the behavi=
or in u-boot should be if successful_boot =3D=3D 1 and tries_remaining =3D=
=3D 0.
>
>> What happens if the tries counter is zero and we attempt to boot with
>> dec_tries=3Dtrue? In that case, we will decrement tries_remaining which =
is
>> an uint8_t (see: android_bootloader_message.h).
>
> As I read the code, dec_tries only decrements tries_remaining if successf=
ul_boot =3D=3D 0. So in the case where dec_tries =3D=3D true, tries_remaini=
ng =3D=3D 0, and successful_boot =3D=3D 1, the decrement would be skipped, =
which aligns with the behavior for a case where tries_remaining > 0.
>
> I'm not too picky with a solution here. A valid alternative solution woul=
d be to simply update the comment at android_ab.c:276. I do think I prefer =
aligning the code to match the comment as it makes more sense to be able to=
 boot a slot when successful_boot =3D=3D 1, regardless of tries_remaining. =
However, if that goes against the spec, simply fixing the comment makes mor=
e sense.
>
> Please let me know what you think and what solution is preferred.

I've looked at another implementation of A/B slot booting in Qualcomm's
bootloader (EDK2):

https://git.codelinaro.org/clo/la/abl/tianocore/edk2/-/blob/uefi.lnx.5.0.r2=
5-rel/QcomModulePkg/Library/BootLib/PartitionTableUpdate.c?ref_type=3Dheads=
#L1846

We can see in FindBootableSlot() that it's possible to boot a
slot with successful_boot =3D=3D 1 and tries_remaining =3D=3D 0

Therefore, I believe your patch is correct.

Again, sorry for the long delays. I'll do my best to be a bit more
response once you have resend this patch in an applicable format (with
proper whitespacing and such)

Consider tooling such as b4 to help you with sending:
https://b4.docs.kernel.org/en/latest/contributor/overview.html
https://people.kernel.org/monsieuricon/sending-a-kernel-patch-with-b4-part-1

Thanks!
Mattijs

>
> Best,
> Colin
>
> ________________________________________
> From: Mattijs Korpershoek <mkorpershoek@kernel.org>
> Sent: Thursday, April 9, 2026 05:21
> To: Pinnell McAllister, Colin <Colin.McAllister@garmin.com>; u-boot@lists=
.denx.de <u-boot@lists.denx.de>
> Cc: Pinnell McAllister, Colin <Colin.McAllister@garmin.com>
> Subject: Re: [PATCH] android_ab: fix slot selection
>
> Hi Colin,
>
> Thank you for the patch.
> Sorry for the late review. For some reason I have not been cc'ed so I
> missed this.
>
> Please use ./scripts/get_maintainer.pl -f boot/android_ab.c next time
> you send a patch.
> See: https://urldefense.com/v3/__https://docs.u-boot.org/en/latest/CONTRI=
BUTE.html*contributions__;Iw!!EJc4YC3iFmQ!Tlm_0_94q_aNcwZ072h7OjCsbyXAaN6bx=
5DgRMsDkFUXhf8ofhAJ1slRLYnu1EpkNnuaZHqRBDVgEpNOTGCclGX-d_1n$
>
> On Fri, Mar 13, 2026 at 15:14, Colin Pinnell McAllister <colin.mcallister=
@garmin.com> wrote:
>
>> The boot selection rules state that a slot is bootable if it is not
>> corrupted and either has tries remaining or has already booted
>> successfully. However, slots that have tries_remaining =3D=3D 0 and
>> successful_boot =3D=3D 1 will be disregarded when picking the slot to
>> attempt.
>
> Can you please give me more references to the boot selection rules?
> Is this just the code comment that's mentioned (boot/android_ab.c:276) ?
>
> I've checked:
> * https://urldefense.com/v3/__https://source.android.com/docs/core/ota/ab=
__;!!EJc4YC3iFmQ!Tlm_0_94q_aNcwZ072h7OjCsbyXAaN6bx5DgRMsDkFUXhf8ofhAJ1slRLY=
nu1EpkNnuaZHqRBDVgEpNOTGCclOK45V17$
> * https://urldefense.com/v3/__https://source.android.com/docs/core/ota/ab=
/ab_implement__;!!EJc4YC3iFmQ!Tlm_0_94q_aNcwZ072h7OjCsbyXAaN6bx5DgRMsDkFUXh=
f8ofhAJ1slRLYnu1EpkNnuaZHqRBDVgEpNOTGCclDWZu3M8$
> and it's unclear to me from that.
>
> Then, I've looked a bit at the default bootcontrol AIDL hal at:
> https://urldefense.com/v3/__https://android.googlesource.com/platform/har=
dware/interfaces/*/refs/heads/main/boot/aidl/default/Android.bp__;Kw!!EJc4Y=
C3iFmQ!Tlm_0_94q_aNcwZ072h7OjCsbyXAaN6bx5DgRMsDkFUXhf8ofhAJ1slRLYnu1EpkNnua=
ZHqRBDVgEpNOTGCclARJQAuu$
>
> It seems to be using libboot_control as a static library.
> libboot_control tells us that a slot is considered unbootable when:
> tries_remaining !=3D 0;
>
> See:
> https://urldefense.com/v3/__https://cs.android.com/android/platform/super=
project/*/android-latest-release:hardware/interfaces/boot/1.1/default/boot_=
control/libboot_control.cpp;l=3D332?q=3Dlibboot_control__;Kw!!EJc4YC3iFmQ!T=
lm_0_94q_aNcwZ072h7OjCsbyXAaN6bx5DgRMsDkFUXhf8ofhAJ1slRLYnu1EpkNnuaZHqRBDVg=
EpNOTGCclOsUzpyr$
>
>>
>> Update the selection logic so slots marked successful remain eligible
>> even when their tries counter is zero. Also include the successful_boot
>> state in the unbootable-slot debug output.
>
> What happens if the tries counter is zero and we attempt to boot with
> dec_tries=3Dtrue? In that case, we will decrement tries_remaining which is
> an uint8_t (see: android_bootloader_message.h).
>
>>
>> Signed-off-by: Colin Pinnell McAllister <colin.mcallister@garmin.com>
>> ---
>>
>> An alternative would be to keep the existing behavior and update the
>> comment in boot/android_ab.c:276 to remove the successful_boot
>> condition. I do prefer updating the logic to match the documented rules.
>> Currently, the userspace AB code will need to increment the tries
>> counter for a slot that has booted successfully but has no tries left.
>>
>>  boot/android_ab.c | 7 +++++--
>>  1 file changed, 5 insertions(+), 2 deletions(-)
>>
>> diff --git a/boot/android_ab.c b/boot/android_ab.c
>> index 13e82dbcb7f..93e74f81d4b 100644
>> --- a/boot/android_ab.c
>> +++ b/boot/android_ab.c
>> @@ -289,11 +289,14 @@ int ab_select_slot(struct blk_desc *dev_desc, stru=
ct disk_partition *part_info,
>>         slot =3D -1;
>>         for (i =3D 0; i < abc->nb_slot; ++i) {
>>                 if (abc->slot_info[i].verity_corrupted ||
>> -                   !abc->slot_info[i].tries_remaining) {
>> +                   (!abc->slot_info[i].tries_remaining &&
>> +                        !abc->slot_info[i].successful_boot)) {
>>                         log_debug("ANDROID: unbootable slot %d tries: %d=
, ",
>>                                   i, abc->slot_info[i].tries_remaining);
>> -                       log_debug("corrupt: %d\n",
>> +                       log_debug("corrupt: %d, ",
>>                                   abc->slot_info[i].verity_corrupted);
>> +                       log_debug("successful: %d\n",
>> +                                 abc->slot_info[i].successful_boot);
>>                         continue;
>>                 }
>>                 log_debug("ANDROID: bootable slot %d pri: %d, tries: %d,=
 ",
>> --
>> 2.53.0
>>
>>
>> ________________________________
>>
>> CONFIDENTIALITY NOTICE: This email and any attachments are for the sole =
use of the intended recipient(s) and contain information that may be Garmin=
 confidential and/or Garmin legally privileged. If you have received this e=
mail in error, please notify the sender by reply email and delete the messa=
ge. Any disclosure, copying, distribution or use of this communication (inc=
luding attachments) by someone other than the intended recipient is prohibi=
ted. Thank you.
>>
>> ________________________________
>>
>> CONFIDENTIALITY NOTICE: This email and any attachments are for the sole =
use of the intended recipient(s) and contain information that may be Garmin=
 confidential and/or Garmin legally privileged. If you have received this e=
mail in error, please notify the sender by reply email and delete the messa=
ge. Any disclosure, copying, distribution or use of this communication (inc=
luding attachments) by someone other than the intended recipient is prohibi=
ted. Thank you.
>
> ________________________________
>
> CONFIDENTIALITY NOTICE: This email and any attachments are for the sole u=
se of the intended recipient(s) and contain information that may be Garmin =
confidential and/or Garmin legally privileged. If you have received this em=
ail in error, please notify the sender by reply email and delete the messag=
e. Any disclosure, copying, distribution or use of this communication (incl=
uding attachments) by someone other than the intended recipient is prohibit=
ed. Thank you.
