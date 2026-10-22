Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6E88606A323
	for <u-boot@archiver.kernel.org>; Thu, 22 Oct 2026 12:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=RbhavkVt;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DmGuHCG6
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 83DDA6069C;
	Thu, 22 Oct 2026 12:53:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id orcWhOhsYHzi; Thu, 22 Oct 2026 12:53:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org B41076087B
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792673634;
	b=EwSYacWbZtmxREE9EhOtjBItlhF0FSxtS8a+r7/zuiGdk20F5ugBGB7DVkfZgy1gnBfA
	 S1pcWw9afs1TNd0nmMMuJwI70VMg12TpCf6G0x9c1B7JQ4uD2QPDXe18YNv0URRYZT7Sd
	 RT83ROFGzTaX5WTFXc++Uqrb5I9jcEHc7W7a3vqj3KOtJbroOygcOtTqo/zI4MhdEOxHa
	 RDzykgYwSJpyaVHA+XjyQhhcWIxylEblcOX593S1lmqIT+5VMthSFnMq5HSQql7adYlYe
	 JcVo98gpzF8gdUzhcbNFjSiGg+EjzMteurV0+rm55zu0mwvccAbjpuB6eexuc6W2V3g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792673634;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:To:Cc:Subject:In-Reply-To:References:
	 Date:Message-ID:MIME-Version:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=QBznzcMD8YFtut2CB1Nf+IXd0OgYmL470Rwq7h0XQ/k=;
	b=fclDFJkxpPuMoPHb+NHktBMThIRW3/gzkEbYssB8f8pROIGpAOXYxo0Wa5EAWj4x0MAI
	 PLsE3lyQAXwpIfIJYvYVkCSFds0vIm4btYAQDYs1JrNV6UEgXgi+FAGqI8cgUmw3kIPks
	 VPaw5tIs/BjhG5ouLGoWQzRKJHn3DtkmYH/IzmhfiuevNMWEzcSdpeUj6oZv6U74ScYKg
	 mKzyvnrV9nsBjLSq0qzSTCZX/29+gjRaV72OOAq6AYM9bwk0DHChXr7LG41oWnmR9D3Nn
	 tQ400n0/a58EcqOWmsozSTG9bx4YLnfFN8P/yRTB+ojngjtKuif+u/ntZgZUSzVhd9A==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	dmarc=pass header.from=kernel.org;
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DmGuHCG6;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792673634;
	bh=QBznzcMD8YFtut2CB1Nf+IXd0OgYmL470Rwq7h0XQ/k=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=RbhavkVtRz0lbwHk3vaE4uBnFTLB7acSuce5Pb3F7VABDDDfRD1Ke0kDbKgzvRd+K
	 2lxPhl9ERJp4VO7domVH7T4Y/ctM39f8SNcJegmHotO621K0GyKcxwFctZcSRddzCG
	 Wwlnyoivy5tKmIHYTfZHEtTOmvcuIWKAR0zkjWbYhRTQ03C8DzDij2/ROWUgBglVAu
	 yetmM70vrVUC6YieFfkdAuja7GfO0hb7DuY8a1fJ13bBc3uj5QaYvPtUf+kcfqq57Q
	 91ZLI0QJoM2RQnnEYlJkQsTDaG+tyUfv+tHo2sPTcAhNaxYOsFCEDusMenJju/9KBQ
	 TR5R42/cQNl9g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id B41076087B;
	Thu, 22 Oct 2026 12:53:54 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 711823C1
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 12:53:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 634BC608AB
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 12:53:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vqagNRD_kMlD for <u-boot@lists.u-boot-project.org>;
 Thu, 22 Oct 2026 12:53:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 836C46069C
Authentication-Results: smtp3.osuosl.org; arc=none
 smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792673632;
 b=GMyG9erBEgCdMEmwDB20YQIK+e3JGdpCtf18saVvF2JS6w8Cq2f1Y9MjhbmlG7xtcQN3
 kacxBZt7+XRbrvXKEB9qK72MU6BNyWbO9iCoxFkooh5R1CdHWp09PIVayFWr57GFf35aE
 qK3ho0E6uF5MoNhVySrtMyIpxM4vPWoFfQT3ybwkeZNvILRy7kCry6KGj+KTH8X+OnG1f
 NnGRzf7Bf9bdxNBNX8ArlftahPqPRakiYS9AHHfo8RcUuXIpY7BGpad9dihXljsRpZ+f+
 AbzkE3kijydVGzo7UNg7YNC+mRCDoE+yyhB2DYNEqd9ePE1K0eL0CzW1IwXv1O0ccPw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792673632;
 h=Received-SPF:Received:Received:DKIM-Signature:From:To:Cc:Subject:
 In-Reply-To:References:Date:Message-ID:MIME-Version:Content-Type;
 bh=QBznzcMD8YFtut2CB1Nf+IXd0OgYmL470Rwq7h0XQ/k=;
 b=EupvxPJ7YinhgRE+5Mm4kM1iVZ5Vv4QZnhdX1rGp4WyLpBsoDble59X8yobAn2U/x3Y0
 97TvhGxNqYxlUhDWo5HUB6BpYtmiz8TdhbSwOUtTkzHl74zH2NuD7iBUE+23NnOMcAfIS
 lhda/T4CmZGkSrh8H2Eu7nxV70xUTL6cVBDGD4putJg2QrbbHGjW1V5iLavzeDux6VYyx
 J8xK4g15qBDe9iNVKJ2ZWvGCiRR+9wYkAOtjUiUqDzAAzvhMOgaRtLqfMaHiNdhBGH2Fx
 6bazmuMXVJlUKWUMP7YbkqCKtdg6VsOszq1vYMS3mqyD1QsSpmdNbFE/thjmz4IsYvQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=DmGuHCG6; 
 arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=mkorpershoek@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=DmGuHCG6
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 836C46069C
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 12:53:52 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 39698408A4;
 Thu, 22 Oct 2026 12:53:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D4A51F000C1;
 Thu, 22 Oct 2026 12:53:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792673631;
 bh=QBznzcMD8YFtut2CB1Nf+IXd0OgYmL470Rwq7h0XQ/k=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date;
 b=DmGuHCG6zSrm32kYUFuvoxKrb2VUUxPwfgwKMr5XcJthXmS12HARcllt0LIYl2HrJ
 HW+z50jZru+u6eUSTFyxb3pGDNTfCJROP669cTk8eQ/AZQpcD9/jpazwbloUU44PnD
 hjJ4PGwm8hBgnuUXjdHTaEOPzlHvUq8CIHTgNxp+mzLnmQakwOlO5GultDYbFn9kBO
 5il429H1N1iF8yZHFLM7ZIv1oVM4/+xvnq5yl12bzvywCuxReFAu1QlHqiFbkMCdH5
 OtibMhNwGIE5bdkc9j6qg0GjsDNDHatFGNYvhd2bO6jYPn4QJCCM0vlaJtThQ34E22
 LHm3Sw4KbAGTQ==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Simon Glass <sjg@chromium.org>
Cc: Igor Opaniuk <igor.opaniuk@gmail.com>, u-boot@lists.u-boot-project.org,
 Jan Kehren <jan.kehren@emteria.com>, Guillaume La Roque
 <glaroque@baylibre.com>, Tom Rini <trini@konsulko.com>, Simon Glass
 <sjg@chromium.org>, Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
Subject: Re: [PATCH v2 09/10] test/py: avb: Add sandbox AVB testing with
 dedicated mmc12 device
In-Reply-To: <CAFLszTiY1RbqFQQX2yP+r1coYEwpkU0M2qxTfvwgnGCyBhiPng@mail.gmail.com>
References: <20261020-test-avb-fixes-v2-0-997f8f04fd3f@kernel.org>
 <20261020-test-avb-fixes-v2-9-997f8f04fd3f@kernel.org>
 <CAFLszTiY1RbqFQQX2yP+r1coYEwpkU0M2qxTfvwgnGCyBhiPng@mail.gmail.com>
Date: Thu, 22 Oct 2026 14:53:48 +0200
Message-ID: <xhkdbbj8lq4kj.fsf@mkorpers-koolstof.csb>
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
	SPF_HELO_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Simon,

Thank you for the review.

On Thu, Oct 22, 2026 at 01:26, Simon Glass <sjg@chromium.org> wrote:

> Hi Mattijs,
>
> On 2026-10-20T09:25:49, Mattijs Korpershoek <mkorpershoek@kernel.org> wrote:
>> test/py: avb: Add sandbox AVB testing with dedicated mmc12 device
>>
>> Right now, sandbox runs the AVB tests using mmc1.img, which contains a
>> fedora image.
>> This does not really make sense. We should test on an mmc device which
>> has a proper vbmeta partition instead.
>>
>> Add a new mmc12 in sandbox which contains all required partitions for
>> proper AVB testing.
>> Use the mmc12 device in the avb tests only when running in sandbox.
>> The mmc12 DT node gets enabled by the avb_device_id fixture if CMD_BIND
>> is available.
>>
>> Note: the vbmeta.img has been generated using:
>>
>>     $ ./avbtool.py add_hash_footer \
>>                    --image boot.img \
>>                    --partition_name boot \
>>                    --partition_size 4194304
>>
>> [...]
>>
>>  arch/sandbox/dts/test.dts                   |  8 +++
>>  test/py/tests/test_android/android_image.py | 15 ++++++
>>  test/py/tests/test_android/test_abootimg.py | 77 +++++++++++++++++++++++++++++
>>  test/py/tests/test_android/test_avb.py      | 26 ++++++++++
>>  4 files changed, 126 insertions(+)
>
>> diff --git a/test/py/tests/test_android/test_avb.py b/test/py/tests/test_android/test_avb.py
>> @@ -22,7 +25,30 @@ temp_addr2 = 0x90002000
>> +        mmc_dev = 0xc
>> +        fname = os.path.join(ubman.config.source_dir, f'mmc{mmc_dev}.img')
>> +        if not os.path.exists(fname):
>> +            setup_android_avb_image(ubman)
>> +            ubman.restart_uboot()
>
> Just to check, is the restart needed? The mmc12 node is disabled, so
> nothing probes it until the 'bind' below. Since sandbox_mmc_probe() is
> where the file gets mapped, the new image should be picked up without
> restarting U-Boot.

I did not give this enough thought and copied this from somewhere else.
You are right, the restart is not needed. I will drop in in v3.

>
>> diff --git a/test/py/tests/test_android/test_avb.py b/test/py/tests/test_android/test_avb.py
>> @@ -22,7 +25,30 @@ temp_addr2 = 0x90002000
>> +        ubman.run_command(f'bind /mmc{mmc_dev} mmc_sandbox')
>> +        # Run mmc list to ensure that mmc_sandbox driver is probed
>> +        ubman.run_command('mmc list')
>
> The fixture has function scope, so this bind runs for each AVB test in
> the same U-Boot session. Since bind_by_node_path() doesn't check
> whether the node already has a device, each later test adds another
> mmc12 device with the same alias seq. The tests may still pass because
> the first device is found first, but it leaves junk in driver model.

Indeed:

=> dm tree mmc12
 Class     Seq    Probed  Driver                Name
-----------------------------------------------------------
 mmc          12  [   ]   mmc_sandbox           mmc12
 blk           3  [   ]   mmc_blk               |-- mmc12.blk
 bootdev      14  [   ]   mmc_bootdev           `-- mmc12.bootdev
=> bind /mmc12 mmc_sandbox
=> dm tree mmc12
 Class     Seq    Probed  Driver                Name
-----------------------------------------------------------
 mmc          12  [   ]   mmc_sandbox           mmc12
 blk           3  [   ]   mmc_blk               |-- mmc12.blk
 bootdev      14  [   ]   mmc_bootdev           |-- mmc12.bootdev
 mmc          12  [   ]   mmc_sandbox           `-- mmc12
 blk           4  [   ]   mmc_blk                   |-- mmc12.blk
 bootdev      15  [   ]   mmc_bootdev               `-- mmc12.bootdev
=>

> please can you either unbind after the test (yield, then 'unbind
> /mmc12') or bind only if the device isn't already there? it would also
> be worth checking the bind output, so that a failure shows up here
> rather than later as a confusing 'avb verify' error.

I will check the bind output in v3.
I'l also do an unbind using yield followed by 'unbind /mmc12'

>
> I'm also wondering whether we lose something by not doing the
> disk-image setup upfront? Can we still run C tests on it?

You mean doing the disk-image setup at the same time we create the other
disk images in test_ut.py (test_ut_dm_init_bootstd) ?

I have considered this. I chose to create the image from the tests
because it allows us to start from a clean state.
For example:

$ git clean -xdf
$ ./test/py/test.py --bd sandbox --build -k test_avb_verify -s -v

If we create the images from another place (like test_ut.py) it means we
have to run those first.

We could run C tests but mmc12.img has been made exclusively for the AVB
tests for now.

If we need to access them from C we can revisit as of where to create
the disk image.

>
> Regards,
> Simon
