Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB4F5606A339
	for <u-boot@archiver.kernel.org>; Thu, 22 Oct 2026 12:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=KBVqVP/g;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UcV+bOpG
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id EFD49409BA;
	Thu, 22 Oct 2026 12:22:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5ZVHMpe_Uuuu; Thu, 22 Oct 2026 12:22:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 614D3409AC
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792671761;
	b=jzA5nGJdRkbjNjMsdV9fWP9a2M6npSbHhNlHeHVUaf74qpMhBuQzoautUmhdi/fNpQiN
	 odiGXZGAfPn64om4uk8cn26Q/4LMZKjrryQZJ7qpMFwB3Ehn6H9WeUXEtJ6Q94pss/TQz
	 7sVN8v8NkgAxc3LO0UNT4/c09xQpK+a4x7IruprEylidgeJZVXUUsHhCvUZn9AxLayNwA
	 7vIAFrpHCad8bRBhNHlvX4dfwvK4VCkMMzIiDF/6psgQiW5aey0/nZe+/J8Z9fNR0dkjO
	 45M6v5z7mnkQxeO5KcEIyKJv3bBEJg2BPyeo/ITeMwxkEvIAphNaFYb0HBLgNfHt9GA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792671761;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:To:Cc:Subject:In-Reply-To:References:
	 Date:Message-ID:MIME-Version:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=BBL1C7ST0q1/4575KEsUl1lsaYnc2AhzZQFP1g3rn5o=;
	b=lCyQ3heltLBqy57HRwPGyGSv1Pwdkw5um9uiP8WsuaIrQu+u1XXmDwuAEZrE+n6xrR7/
	 SoorC70FnPs4IKgUe6UOaSCEKh20YKZIVgh0fbBYf26XNBcPlCkZCjlUTvptbYYndX2Bk
	 h5KrLa0wgeHvdmzAZDYsjk/qSy+UsIVODW7R+NqOJOyZE4dPivWMlGqWAKNXSsQHIye77
	 QA7Ng4L14e0KnIKJsisDTKIcStxxsKt1XAU5ZaZqVSQleC9DpvQnX0eLj87n2YAmwUfFn
	 C+gmt3dZCeuGMociBke5dPxZzJrdExmy44UQsmnERLK+V6KQ22CJ4bfqkPwLM78o4bA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	dmarc=pass header.from=kernel.org;
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UcV+bOpG;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792671761;
	bh=BBL1C7ST0q1/4575KEsUl1lsaYnc2AhzZQFP1g3rn5o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=KBVqVP/g+BnXBRXd3VMfklHyygZuWye6muicOYWJO5uPJ16eP70qUpIs3fGCAd29N
	 WFXS5eT7gxYPhjkOTcWClS+ivpu5TI38jGICUUURuYVdg4tFodmuGVHubSdypFZjpn
	 aQd+htA15oyxx8jOyBO2aC/mt4ZeXaHb35xyQ8pQntgozWfpfdjUGlIU0fEM3vezC+
	 4q8nyRPhPyX/64V+aI3DMCknTkQaTrlGLjoPGgkCMsny2BtIM9iWt6Bj2mtgH1fsav
	 ddBQXrJqyub8kKMdnoEBkogGPi/rBBvJK57pGOJMkNWexMgJurHfdKFdHznP9qvs4J
	 UCOj+D4PdpmKA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 614D3409AC;
	Thu, 22 Oct 2026 12:22:41 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 236243C1
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 12:22:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 15133409AC
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 12:22:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8HnBZFp9YLpU for <u-boot@lists.u-boot-project.org>;
 Thu, 22 Oct 2026 12:22:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 5AB69409A3
Authentication-Results: smtp4.osuosl.org; arc=none
 smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792671758;
 b=iUPXiWfZXk6+PobjHFYps1tkgL3rd/AOG9IKT7IOwrb3qkF6xfWl1iyq5y2JfyhmkfPk
 AljRa5SZAXK9DEPiEqJBtGv3LBw2uZyHpfBT1jzkr/A0T1lXRBlBo2BUmUOvrVwBoFxc7
 Oslaj5OV4mP8XFEDZKVmN+ixdd0e8IWcE3Ch8jJqMg6JhrEmAAM9CJEtCuLOLWePrc14N
 q5JmJyMORb3Bga8WXgtQFHqWyXODP4L0LSAxLkQsbxbemot51qxXVi8pFngjJZGVk9Ouh
 d/l/RoIfXVxCm14vGj9Qs41mOtOr/zEQjRGdabIS2NroFmGT8FdN0TM5pSuNYMCbqGw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792671758;
 h=Received-SPF:Received:Received:DKIM-Signature:From:To:Cc:Subject:
 In-Reply-To:References:Date:Message-ID:MIME-Version:Content-Type;
 bh=BBL1C7ST0q1/4575KEsUl1lsaYnc2AhzZQFP1g3rn5o=;
 b=ZSgPDgSFeEFx9jVyiCi2HhsjpaQu381EwZRIcOO30PHuAquMFWbQm1FLdnwF9Yy3tpPh
 RayJAXuztLVsjJcPE6cho9qI4CxvklvbkPS7mxKKMW6CPcKsE2S65HYZvrOekBIHqQaxh
 tc7J9TU8md+PM9B+hQKHrNbvTgiYwYNiTV1UiJkmXqkEhjsIrKBfjRhx332eyGOqjnWKT
 N50SYupIEpCDHKo5VQJfOvwsUd+U/QJafOtUHlaoEZ6P0TihtlQHJH6TU0rYElXa56o+f
 LOTWzTudFYa4K5s3VcE4d3QW+pDFSq7tJMxc76qcOY77Xrkd2ifQbQhacgbPanCuzsQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=UcV+bOpG; 
 arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=mkorpershoek@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=UcV+bOpG
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5AB69409A3
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 12:22:37 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 9C2DB601FD;
 Thu, 22 Oct 2026 12:22:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D58311F000C1;
 Thu, 22 Oct 2026 12:22:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792671755;
 bh=BBL1C7ST0q1/4575KEsUl1lsaYnc2AhzZQFP1g3rn5o=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date;
 b=UcV+bOpGErpk88MHY6irYceDF1kw+vGolCwSajTDrjJKE2KRxqclefA9otcB4ZwSC
 UPtOCapPv+r2nk79FGUhcAZOuoblit9b3qtuBL0qQIIlTj+40XF52QvpayUMm/S/tc
 XBP6aZc/rpSx8qDhe8dzESc+bGGQ2DGGRImSM4m2qK9cfRChxdkmH4pZkVEjBBfENC
 zPo8JDMMakh1fvXex86WQ2GrpYtPQPlVxBe43jRKfcs+Fm0M3qjmZeV6xP+3wSHNpg
 pquabHqKIP3T8vlrzfGOmPUAdzXhLqW3gsHekgHQ0cPj7bV7MJctNfzxLB44e0+R2D
 sWM5g1Ni0DTFA==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Simon Glass <sjg@chromium.org>
Cc: Igor Opaniuk <igor.opaniuk@gmail.com>, u-boot@lists.u-boot-project.org,
 Jan Kehren <jan.kehren@emteria.com>, Guillaume La Roque
 <glaroque@baylibre.com>, Tom Rini <trini@konsulko.com>, Simon Glass
 <sjg@chromium.org>, Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
Subject: Re: [PATCH v2 10/10] test/py: avb: Fix find() logic when matching
 response strings
In-Reply-To: <CAFLszTgWWB_ez_ue6WDToWdCKFAbTbh+5zoyY9mxfj72OyHrDg@mail.gmail.com>
References: <20261020-test-avb-fixes-v2-0-997f8f04fd3f@kernel.org>
 <20261020-test-avb-fixes-v2-10-997f8f04fd3f@kernel.org>
 <CAFLszTgWWB_ez_ue6WDToWdCKFAbTbh+5zoyY9mxfj72OyHrDg@mail.gmail.com>
Date: Thu, 22 Oct 2026 14:22:32 +0200
Message-ID: <xhkdbecdhq60n.fsf@mkorpers-koolstof.csb>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Simon,

Thank you for the review.

On Thu, Oct 22, 2026 at 01:26, Simon Glass <sjg@chromium.org> wrote:

> Hi Mattijs,
>
> On 2026-10-20T09:25:49, Mattijs Korpershoek <mkorpershoek@kernel.org> wrote:
>> test/py: avb: Fix find() logic when matching response strings
>>
>> The AVB test suite runs some avb commands (such as "avb verify") and
>> then parses the console output for success/failure.
>>
>> It does so by using the string.find() function which returns:
>> * -1 when the subsystring does not exist
>
> Typo: 'subsystring' should be 'substring'

Will fix in v3.

>
>> * 0/a positive number when the substring exists
>>
>> For example, here is the output of:
>> $ ./test/py/test.py --bd sandbox --build -k test_avb_verify -s -v
>>
>> Hit any key to stop autoboot: 0
>> => =>  avb init 1
>> => => avb verify
>> get_partition: no MMC device at slot 1
>> get_partition: no MMC device at slot 1
>> avb_slot_verify.c:644: ERROR: boot: Error loading footer.
>> Verification failed, reason: I/O error occurred while trying to load data
>> => PASSED
>> [...]
>>
>>  test/py/tests/test_android/test_avb.py | 12 ++++++------
>>  1 file changed, 6 insertions(+), 6 deletions(-)
>
>> diff --git a/test/py/tests/test_android/test_avb.py b/test/py/tests/test_android/test_avb.py
>> @@ -64,7 +64,7 @@ def test_avb_verify(ubman, avb_device_id):
>> -    assert response.find(success_str)
>> +    assert response.find(success_str) != -1
>
> It would be worth using the 'in' operator here and elsewhere, e.g.
> 'assert success_str in response', since that is the usual Python
> idiom. It also helps with debugging: pytest's assertion rewriting then
> shows both the expected string and the console output on failure,
> whereas '!= -1' just gives '-1 != -1'. What do you think?

Indeed, that's a good suggestion, thank you. Will do in v3.

>
> Regards,
> Simon
