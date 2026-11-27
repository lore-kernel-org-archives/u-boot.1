Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4F7A606A338
	for <u-boot@archiver.kernel.org>; Fri, 27 Nov 2026 12:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=jjmWG/ru;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=J0gF8Rwi
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 89156409C1;
	Fri, 27 Nov 2026 12:21:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KQbwPl8MVx3R; Fri, 27 Nov 2026 12:21:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org C247240A10
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795782081;
	b=jq5qXKPQCkPU+J+tYs5E+FOe1MXNVs1xQ/6UgGdHOUw04ZqEY9k6R5DM9NBcZPtl/Fup
	 RtoSlq8XneraUpHZDYFjTORQbKu/AvABK7PYqG2Z0HLS2GoJavg9fGRondw4K3rc0PVk8
	 pfPZmcd1gurPkMJVEC2SxjGTFimp3z83PJcuAZDVDhALlnyMbaDxCqSg4mCZ9iEU7+f59
	 A0mMko1YQDH0u5u2Vx7uwQFCdjh5FoxzQlQNsXotiQ+brL47dMTJW5aW5s9167q4bNRBa
	 VAevpSIbZwyAyoj4i5L7rBg4nmYE7L75+ecFyq59Z17P7m2Z2tNdhGl1YcReV1Hreog==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795782081;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:To:Cc:Subject:In-Reply-To:References:
	 Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=6Whmo8fyN+hHJGcgWQo+3RtVgOUkYgWGxmvAmCM0TeA=;
	b=BIY/4A0XEuiije/VKvSwfZ05oIpIL8LGUMU9PQQxC50AehkuQ4ggcZ4P1LGSSooRnbBn
	 BYMgsNXYmdhi6mYbYZIcWlXLUhr8oNll+Y3lyc75S1ZAemLbCfxoGairgSLn2M9yod8HU
	 9cpFJIQanSLXX8NLrsxp3r6dp+mzQOvWAMEUnCuafzOZxVpJ6TVO/90TPbXsS0XOzLiY7
	 RYr+8yvm+szN9rBve/heuX7YSTQz92Kx4+rRyZ5xPV0Sio2j6IVt3sw6XYCukMtiKlXw0
	 /RGnZgZan72UheU3wJxoqBtxnv1N4wItqaQmEmNlePVe+UQJzshjXPwH7kMUS5pturA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795782081;
	bh=6Whmo8fyN+hHJGcgWQo+3RtVgOUkYgWGxmvAmCM0TeA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=jjmWG/ruJXrR5WhCodj0XJeiU4zzX0uujXzFVQqpuiK1x4s6oeV9aAP8MdqjmLQT7
	 bOst9XX8cdjHnA2rruAvB6a5bXmr9HKc+2/Xm8WRHReAkA0kUqQZCeCrgEc/ln+/Vt
	 GFDXcERstKvQ3vOaenih3MdzwPypfI7qmIXl6eSx2mPz2vgXmdd+ReVSoBfQt2ooz5
	 Sow8L5agfjRnQVuYhkaT0+zN19m8KtId0Lk4dPdSqV/VDfDwmxQXpkF0iuSxurfvz7
	 ZWmKV+dsNrYOflGHFFtAZBOgkBLJnZWqNLLJkngwOvrL2sutuV42L4AyWAbtisHcv/
	 D9gdSqQpHyUQg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id C247240A10;
	Fri, 27 Nov 2026 12:21:21 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id ACFC6D1
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 12:21:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 9E47060AAF
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 12:21:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7eLT7kSMhxx0 for <u-boot@lists.u-boot-project.org>;
 Fri, 27 Nov 2026 12:21:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org ACF2860AAC
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=172.105.4.254
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org; envelope-from=mkorpershoek@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=J0gF8Rwi
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp3.osuosl.org (Postfix) with ESMTPS id ACF2860AAC
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 12:21:18 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 3A04B62B75;
 Fri, 27 Nov 2026 12:21:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1074C1F00932;
 Fri, 27 Nov 2026 12:21:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795782075;
 bh=6Whmo8fyN+hHJGcgWQo+3RtVgOUkYgWGxmvAmCM0TeA=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date;
 b=J0gF8Rwi8XLUDNdSFt6yQidwHFELFBV0xC7HtyRXJrMkvZPpLbpqqn9gg++X9makH
 fy3M/Yn2ZxUBv7BfLR9Kgc3nt1xNCpXSHFirRhPVvzZgcibO7rku8+OqnZKR0qxUjy
 LzpEhPHgp7Ban3tV9T2Lm5fvx3le9I4mf088Y94Mw8fULYurwp4Q2o4KGxlGydADoY
 DkCfBbMgFEL1nNXDsPigzlUr1RdYbwZsOOiELeZZCuByu+T8TinMlZ2x596q1RBCmq
 +M0wmbgRgqV6qMfT5MBCLhyQIw5L+fozUaQxIZVrKNPqiRNg8nUf1nR2DKlPKjZYeg
 do/SSa8e481Gg==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org
Subject: Re: New Defects reported by Coverity Scan for Das U-Boot
In-Reply-To: <CAPzfCAbS0nULr+fVHd52LdYY2CrBYV3wWkM-g+Le+pp7pWnx0A@mail.gmail.com>
References: <20261123223805.GQ3176972@bill-the-cat>
 <CAPzfCAbS0nULr+fVHd52LdYY2CrBYV3wWkM-g+Le+pp7pWnx0A@mail.gmail.com>
Date: Fri, 27 Nov 2026 13:21:13 +0100
Message-ID: <xhkdbwlpyxy6e.fsf@mkorpers-koolstof.csb>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,

On Tue, Nov 24, 2026 at 10:31, Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>=
 wrote:

> Hi Tom,
>
> On Mon, Nov 23, 2026 at 11:38=E2=80=AFPM Tom Rini <trini@konsulko.com> wr=
ote:
>>
>> Here's the report from v2027.01-rc3. Looks like the AVB update
>> introduced a few issues, or at least things to investigate. Thanks!
>>
>> ---------- Forwarded message ---------
>> From: <scan-admin@coverity.com>
>> Date: Mon, Nov 23, 2026 at 4:33=E2=80=AFPM
>> Subject: New Defects reported by Coverity Scan for Das U-Boot
>> To: <tom.rini@gmail.com>
>>
>>
>> Hi,
>>
>> Please find the latest report on new defect(s) introduced to *Das U-Boot*
>> found with Coverity Scan.
>>
>>    - *New Defects Found:* 5
>>    - 9 defect(s), reported by Coverity Scan earlier, were marked fixed in
>>    the recent build analyzed by Coverity Scan.
>>    - *Defects Shown:* Showing 5 of 5 defect(s)
>>
>> Defect Details
>>
>> ** CID 662464:       Memory - illegal accesses  (UNINIT)
>>
>>
>> ________________________________________________________________________=
_____________________
>> *** CID 662464:         Memory - illegal accesses  (UNINIT)
>> /lib/libavb/avb_slot_verify.c: 450             in
>> load_and_verify_hash_partition()
>> 444
>> &slot_data->loaded_partitions[slot_data->num_loaded_partitions++];
>> 445         loaded_partition->digest =3D avb_calloc(digest_len);
>> 446         if (loaded_partition->digest =3D=3D NULL) {
>> 447           ret =3D AVB_SLOT_VERIFY_RESULT_ERROR_OOM;
>> 448           goto fail;
>> 449         }
>> >>>     CID 662464:         Memory - illegal accesses  (UNINIT)
>> >>>     Using uninitialized value "digest" when calling "avb_memcpy".
>> 450         avb_memcpy(loaded_partition->digest, digest, digest_len);
>> 451         loaded_partition->digest_size =3D digest_len;
>> 452         loaded_partition->digest_type =3D digest_type;
>> 453         loaded_partition->partition_name =3D avb_strdup(found);
>> 454         loaded_partition->data_size =3D image_size;
>> 455         loaded_partition->data =3D image_buf;
>>
>> ** CID 662463:       Uninitialized variables  (UNINIT)
>> /lib/libavb/avb_slot_verify.c: 452           in load_and_verify_hash_par=
tition()
>>
>>
>> ________________________________________________________________________=
_____________________
>> *** CID 662463:         Uninitialized variables  (UNINIT)
>> /lib/libavb/avb_slot_verify.c: 452             in
>> load_and_verify_hash_partition()
>> 446         if (loaded_partition->digest =3D=3D NULL) {
>> 447           ret =3D AVB_SLOT_VERIFY_RESULT_ERROR_OOM;
>> 448           goto fail;
>> 449         }
>> 450         avb_memcpy(loaded_partition->digest, digest, digest_len);
>> 451         loaded_partition->digest_size =3D digest_len;
>> >>>     CID 662463:         Uninitialized variables  (UNINIT)
>> >>>     Using uninitialized value "digest_type".
>> 452         loaded_partition->digest_type =3D digest_type;
>> 453         loaded_partition->partition_name =3D avb_strdup(found);
>> 454         loaded_partition->data_size =3D image_size;
>> 455         loaded_partition->data =3D image_buf;
>> 456         loaded_partition->preloaded =3D image_preloaded;
>> 457         loaded_partition->verify_result =3D ret;
>>
>> ** CID 662462:       Uninitialized variables  (UNINIT)
>>
>>
>> ________________________________________________________________________=
_____________________
>> *** CID 662462:         Uninitialized variables  (UNINIT)
>> /lib/libavb/avb_slot_verify.c: 445             in
>> load_and_verify_hash_partition()
>> 439           avb_error(part_name, ": Too many loaded partitions.\n");
>> 440           ret =3D AVB_SLOT_VERIFY_RESULT_ERROR_OOM;
>> 441           goto fail;
>> 442         }
>> 443         loaded_partition =3D
>> 444
>> &slot_data->loaded_partitions[slot_data->num_loaded_partitions++];
>> >>>     CID 662462:         Uninitialized variables  (UNINIT)
>> >>>     Using uninitialized value "digest_len" when calling "avb_calloc".
>> 445         loaded_partition->digest =3D avb_calloc(digest_len);
>> 446         if (loaded_partition->digest =3D=3D NULL) {
>> 447           ret =3D AVB_SLOT_VERIFY_RESULT_ERROR_OOM;
>> 448           goto fail;
>> 449         }
>> 450         avb_memcpy(loaded_partition->digest, digest, digest_len);
>>
>> ** CID 536494:       Integer handling issues  (INTEGER_OVERFLOW)
>> /include/linux/log2.h: 72           in __rounddown_pow_of_two()
>>
>>
>
> Thanks for forwarding the report. I think the three AVB warnings
> (662462, 662463,
> and 662464) are false positives. The early success path for an
> unrequested partition
> leaves image_buf NULL, and partition-load failures and unsupported
> hash algorithms
> skip the copy.

I agree with Igor, these are false positives. I double checked the code
and when we have an "Unsupported hash algorithm", digest, digest_len and
digest_type are indeed not set.

However, we set ret to AVB_SLOT_VERIFY_RESULT_ERROR_INVALID_METADATA,
and in the out label, we call result_should_continue(ret)

result_should_continue(AVB_SLOT_VERIFY_RESULT_ERROR_INVALID_METADATA)
returns false, se we never call avb_{calloc,memcpy}() in this case.

>
> So every path that reaches the copy has already initialized digest, diges=
t_len,
> and digest_type, including when verification errors are allowed.
>
> I did spot a pre-existing issue in the same AVB block (no check for
> avb_strdup(found)) though,
> will send a patch soon.
>
> Thanks,
> Igor
>
>
