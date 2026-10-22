Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AB80606A31E
	for <u-boot@archiver.kernel.org>; Thu, 22 Oct 2026 13:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=paocHGN4;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TFtS2Kth
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E8B3A606E5;
	Thu, 22 Oct 2026 13:24:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ifwLPzJL_k1c; Thu, 22 Oct 2026 13:24:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 348C560787
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792675451;
	b=CPD6FzdqOKnsRz2+8Ovs6vsdvkS0gGJSD/TNcPxwRra1aO0IvoD/eGhqceV33m0Titk/
	 XdtUjoq5Lca5KhVmFdsoifAcWE5wsuJ+UAG1KL5lHFNatt2C06h4oYDgoEZ7nwPe533Ux
	 T2GcmER32q8Nov54/oPQ+HbAYXJdSynrsiT/7jyEJJkyqVhDgwUazx8D/gUTRfL1lMNGd
	 GnKD65bDyD5wh0sErRHjB8l/nyjifTiWcrNe4CnxP/gFaM0wpCogmXfAnOAMYqbM8dNeg
	 FAWS363pQLYedQPgugmBr1fJBnHUFs0/R0qEiXHe+B2ckPLafydZ1Jz30QYdzkN0GVQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792675451;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:To:Cc:Subject:In-Reply-To:References:
	 Date:Message-ID:MIME-Version:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=jWlC4AeX/dTV9BDToYDT0oyednbSy316zsbKLF1iIy4=;
	b=JDUB6mPAWOM5cstumDkJ+5u/5TuVLQtC216Nd8M2C/6WXGzF0FGxRwKvMCpY+juk3zh0
	 S56i0s4DaamXRf4lzdmlp9F4B2zKxQ48Rr8ODcodjQ4szdutxuMCfkcYiNZqqTZcZ6v5T
	 BQiCdcnqWNDrwCFjbJ0ZBEEwF/W4UZDTzLaT8pKIvmmjgwYrm8J3sf7FU9dCvK0cWavc0
	 iFrXmr1P43JKa26FEVN/4sZV2CkC1PAWV/JPZhJElxmSLUW+R4jA+ExNXjc7GIM8wJ7Ah
	 v3f8v8MSoqvOWA6YZbxkATcOqMzXao+uT/MIqS9zt6GBpIcgmT8s+lrInTCguuU4FaQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792675451;
	bh=jWlC4AeX/dTV9BDToYDT0oyednbSy316zsbKLF1iIy4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=paocHGN45QOnqWQ8sj/2nUCxhB6VXkQV86Gum3ZZGMDCN/c+8qcPs/SHT23hh6WNZ
	 ABjVI5h6r0IVHlzn8vlLcsHz2ynYK3uADwTSdIaOjuhgEMv/v8pNRPRDS0vkDzufuB
	 2szYjPw7l/HLU5kDE4OF7zpm3nVrTjQD/Mp69pyJ4djGezuxPvuJnqXf2e/vK+5x31
	 SO4ENaIpBfK7KPHY/MaVl7DNbCZTylIvkr6MzVCZ+OlZxcNs+JDD0Az7Bixh4B3ICp
	 vJ5IF1MoAkoiNp/ett3p03rIBJUYTM48jmTXHE10da9u9BpzsHSNFsm7RY2Q5ZmpCJ
	 R5G6VnoRe6gMQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 348C560787;
	Thu, 22 Oct 2026 13:24:11 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 2892C95C
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 13:24:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 1A88780A7B
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 13:24:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EeOkrw-qhxqC for <u-boot@lists.u-boot-project.org>;
 Thu, 22 Oct 2026 13:24:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 51F9D80A76
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792675449;
 b=onIaBwUROM9AiMLcaoGSbckTp7aU26OKHtgNZqO5vQKZtI88l08mtKCvgFQVfynypWwY
 oR+ZViaFAUQuSeiZKqIie6LZT/V/oD9SaXYwOufiKh3m4yD/x1bLhAm/n4hRjIaPKPMm/
 7xlYEyzM7qcMsjdAIdPHlAEqBQFTXognwoNVIfZ9mgQiLfVWoEYC46dQK7PnMhyzD1zPH
 LJTJaHQvQpcLYGaiI5v52GeN17aHq0jGveiZ43Ap4+oN+r9MaAdJcgrpEiiHA1QgGjj9S
 PB1keNchzoqT8lXTTzN0uREznxy2l7OqxeIV5nO+YrOBmhRrluteBlIozQYowA6xZ3A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792675449;
 h=Received-SPF:Received:Received:DKIM-Signature:From:To:Cc:Subject:
 In-Reply-To:References:Date:Message-ID:MIME-Version:Content-Type;
 bh=jWlC4AeX/dTV9BDToYDT0oyednbSy316zsbKLF1iIy4=;
 b=HNHl2lFVUkfQloAvRXY3n8OVToERh2sw7l2SWzK17QVdifo7JBGZ1ya1yLUJXhHj89qF
 gg7T+w6Gq/PIPJG3Vh31VYu8ARNjq6VNvZ7N7rRvhtABbtNTvrZjOOuFjGO6o2JJCKWCd
 TyoLQdQPeZNa3G2ysIHHU/i0Nr88i7rIVXc8ePYnYcGrEVp7qRtSPE/pa6Laf28Rx5mex
 DA6jgmXTGnnOa+g3M782lie5X1gd03HpgPezLmgzmTsTk2HvpaKBAviNTyv9gOA7nhy1V
 uyDtjDscUrFhxysG2CotcNR7CxpkMIBOMWMMa0UthWemJbtf6JxJvDwNB1ZlEmyv+yg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=TFtS2Kth; 
 arc=none smtp.remote-ip=172.105.4.254
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org; envelope-from=mkorpershoek@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=TFtS2Kth
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 51F9D80A76
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 13:24:08 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 878E0602D4;
 Thu, 22 Oct 2026 13:24:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C07D41F000C1;
 Thu, 22 Oct 2026 13:24:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792675447;
 bh=jWlC4AeX/dTV9BDToYDT0oyednbSy316zsbKLF1iIy4=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date;
 b=TFtS2KthT6HbwLrjwohaH6E+H3WpWFSSqjWZnrmL+9jWJ6Q9jsrWlOdJdC4TbBjKE
 RUFIJSi5Ig8s1Fi1S9wf036qUmML8cKcRx+pHrwp7OKtnAa906P1e38XBQIQZI3Zx0
 x6enQKYv1x3wHMnODdiF8GqgNErq7/UEmF3uTy75b21jHyyimKuZEk6pv9WFzi2BK9
 Xjrj83UoqMKU3r6tWxrTKSHjVdLXy5QAVx9ZzS8MoDwsO4u7iTElZ10tw6g24r8TtI
 2EZhu/dOpcpcBQSg0RvBPtT34jWOc+/rWpU+6FRUg32ahpmYsrPHMS/6xDUCSVpWLu
 41Mna9H1f/0WQ==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Simon Glass <sjg@chromium.org>
Cc: Igor Opaniuk <igor.opaniuk@gmail.com>, u-boot@lists.u-boot-project.org,
 Jan Kehren <jan.kehren@emteria.com>, Guillaume La Roque
 <glaroque@baylibre.com>, Tom Rini <trini@konsulko.com>, Simon Glass
 <sjg@chromium.org>, Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
Subject: Re: [PATCH v2 05/10] test/py: android: Add create_gpt_image() for
 image creation
In-Reply-To: <CAFLszTjD+8B0Mq6ktOrKx94m51n-=R3L0icxuL6qV2SUkvMorA@mail.gmail.com>
References: <20261020-test-avb-fixes-v2-0-997f8f04fd3f@kernel.org>
 <20261020-test-avb-fixes-v2-5-997f8f04fd3f@kernel.org>
 <CAFLszTjD+8B0Mq6ktOrKx94m51n-=R3L0icxuL6qV2SUkvMorA@mail.gmail.com>
Date: Thu, 22 Oct 2026 15:24:05 +0200
Message-ID: <xhkdb7bj9q362.fsf@mkorpers-koolstof.csb>
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
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Simon,

Thank you for the review.

On Thu, Oct 22, 2026 at 01:26, Simon Glass <sjg@chromium.org> wrote:

> Hi Mattijs,
>
> On 2026-10-20T09:25:49, Mattijs Korpershoek <mkorpershoek@kernel.org> wrote:
>> test/py: android: Add create_gpt_image() for image creation
>>
>> There is quite some code duplication between the image creation for
>> mmc7.img and mmc8.img. If we want to add more images, this will be even
>> more duplication.
>>
>> Add a common function, create_gpt_image() which removes all the code
>> duplication.
>>
>> Reviewed-by: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
>> Tested-by: Guillaume La Roque <glaroque@baylibre.com>
>> Tested-by: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
>> Signed-off-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
>> Reviewed-by: Guillaume La Roque <glaroque@baylibre.com>
>>
>>  test/py/tests/test_android/android_image.py | 78 +++++++----------------------
>>  1 file changed, 19 insertions(+), 59 deletions(-)
>
>> diff --git a/test/py/tests/test_android/android_image.py b/test/py/tests/test_android/android_image.py
>> @@ -7,13 +7,12 @@ import os
>> -def setup_android_image(ubman):
>> +Partition = collections.namedtuple('part', 'start,size,name')
>> +
>> +def create_gpt_image(ubman, mmc_dev, required_parts, images):
>>      """Create a 20MB disk image with Android partitions"""
>> -    Partition = collections.namedtuple('part', 'start,size,name')
>>      parts = {}
>>      disk_data = None
>
> This is now a general helper that callers have to fill in, but the
> format of 'required_parts' (a list of dicts with 'num', 'label' and
> 'size', where size is either a sector count or 'NM') and 'images'
> (tuples of partition number, file name and hex data) is only visible
> from reading the body. Please can you add an Args: section to the
> docstring describing each parameter, as set_part_data() has earlier in
> the series? Since the name now says GPT, the docstring could also say
> which mmc image it writes rather than 'Android partitions'.

Ok, will do for v3.

>
> Also, 'disk_data = None' is now redundant since the variable is only
> assigned once, further down. Moving Partition to module level seems
> unnecessary too, since only this function uses it.

Ok, dropped disk_data = None for v3.
Ok, put Partition back into the function for v3.

>
>> diff --git a/test/py/tests/test_android/android_image.py b/test/py/tests/test_android/android_image.py
>> @@ -69,55 +56,28 @@ def setup_android_image(ubman):
>> +def setup_android_image(ubman):
>> +    mmc_dev = 7
>
> This drops the docstring from setup_android_image(), so pylint
> complains at this patch. The next patch adds it back, but it would be
> better to keep it here so that each patch is clean on its own.

Ok, will put the docstring back in in v3.

>
> Regards,
> Simon
