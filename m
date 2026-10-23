Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E222606A333
	for <u-boot@archiver.kernel.org>; Fri, 23 Oct 2026 14:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=ydO4hqks;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ggaDYJL9
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 009AE4094C;
	Fri, 23 Oct 2026 14:30:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1NAn63ydHcT0; Fri, 23 Oct 2026 14:30:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org DFFAB408F8
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792765829;
	b=gK0gpA76quTKtFxpm6afLHJvqKsZtphRbu7R+onaKMhgkW56WswyiGNOE46mxl2Ty1rj
	 WEEy15/flxB8PZX3jmLSmO6XhnbWC4jDrAJyn7zFaMDw7IX2a0W6o09xpbLoDOa8lYSLS
	 ztCRRX8u7pPfJVln3r0I7FO/UW1qIVMPxUWbcNqJCmVWVBTlcxUf5K/3pUozuw//DIqSw
	 5nuPeYYUh1zHdkRN0sgRcYN+KW9w3JYoElVJZc5IdMh2MSTtpdKxWnC5odV1u/fCHgs4A
	 5dl3TuwHG6+iPS1yO0KXY3NQNRuc9gRVBli7viJWcBZTnUi7LrrWtBGuEseRVCC2ZMA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792765829;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:To:Cc:Subject:In-Reply-To:References:
	 Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=Lq9pw9llwfzBROAdKdKbXgd8474rxwyRgo57M5xeQoc=;
	b=CWqUFAgN7oR/v20GutqYeW9YkzQReXcf54CuFC89nK4NmYMF6ZPXrG3pJcoB17FQPam8
	 k2hBVs6lg7o5P40SUuhpEY+0vdZB3MY5DoUiOqQT38P59tBTvp3VeG1Zk3PncKDaU5iD8
	 Fber/kVJcBHs3kU9GKVoPfpkfHoewT7Zt1eic8bLmztSY7hOU06iiLpo6yxx+Iigbic2o
	 lTBepIivk0gWMmq+O2oCi7gWaJjDMqsGV9x9ulCxPPbSYAiWXTS8qSio+1dlIOm3kyV7s
	 0hXOoZXRDKWNy8zOcjv6xnNWdYw6A1LKbtRFT2W8yWU9VYs+EjRZhkOtjY8nWY5a+eA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792765829;
	bh=Lq9pw9llwfzBROAdKdKbXgd8474rxwyRgo57M5xeQoc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ydO4hqksjH7dxZACUubEsogTFuy91/h+gzedDUZEA2iGvHl/Okmov2yYjYD7TxbgL
	 /yynEicjXPnx8DP0K4V+OoT0PkNQIsdDdCJsLWpXqKzbOK9cC/Y4FUjjYcuMTkmuer
	 Jb3T9q+GO6mqwY5uRYd+ih+qu/ujET9/m3RkOmJDsgst0GqdyG1juRjh2wJ/w10t6k
	 /Q+EiTsMBaimflU3zwTCU0xvfK2WV3IXq7O4wLtDzUbYr9EWlqlRJadaPQ29actQUL
	 U/9InR8xm3AlQ6aMdzxsrdA4ksqsJMsJFabHf1cb9OA1DldIqWXox2cFlYYCHm4HqE
	 N2fLxXaARemHA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id DFFAB408F8;
	Fri, 23 Oct 2026 14:30:28 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 4CB3212C
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 14:30:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 3EBE960648
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 14:30:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4KA5CWqDQLqF for <u-boot@lists.u-boot-project.org>;
 Fri, 23 Oct 2026 14:30:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 2104460657
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792765826;
 b=Tr1F9/OJbnzeKWnTT6YNmmDtDoqNIdvgaCTof96NcRp3TtCqxwpw73xolx7wsSQsIygn
 VzLZqO0eBumzpfrNfQqnSeK1S0YKesMMEZfLp38ONf6GkebcLY+a7jRBdf4MdnZQ2ouKO
 NJKUJMQU4f6H9cUTkpY2rVgmPExE8TxsOW0X/q+bCeLrqiQeapCqLF54j1r0SP8oEFMWL
 eJCEqseDo9rHLHfjWE7w7o6cRYI0z2Qipw1YEaepjZLm5pDN49jXmkv7Cm/TkRJXagYuv
 c8WuVpVNq5HLEdAhxS+OIb5HfI+cH22lJwTs9BzcBE0m9oZvGkWWWHeG0wBXWzeIzew==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792765826;
 h=Received-SPF:Received:Received:DKIM-Signature:From:To:Cc:Subject:
 In-Reply-To:References:Date:Message-ID:MIME-Version:Content-Type:
 Content-Transfer-Encoding;
 bh=Lq9pw9llwfzBROAdKdKbXgd8474rxwyRgo57M5xeQoc=;
 b=UdJxS2GZ3XrBjn+IjdJAa1pMnI7MNm479Z11WEI+bSmG55Iv5a55Ib1vZtmWaPebSoPZ
 nwaDez/7Ai/L0dnXxb5S+fTm/3ow27D7+/u9c7nDX7KaL3swaX11AyF2NxXrtdfHAmzfk
 bzcxXWO5P9rOA1h8f9LyjCvV1KvLnIx2DUzTf8muxeh2Mn9bLKcQh59TWvEGulk1Ung//
 cIScEULUEoCQBb2+0OqEAeA79hPtZqTx9Gwcul4s1DUDxA0RwkWJG3Fh8HzQrnpFAz9u/
 KZxrsUOqdCOIHJKDn2kXH+CpeuTsq8ZlTku1BgCI5Nb1ix3YgPwiM5JLLuiKUyGGyww==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=ggaDYJL9; 
 arc=none smtp.remote-ip=172.234.252.31
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=mkorpershoek@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=ggaDYJL9
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 2104460657
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 14:30:25 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 258FA43920;
 Fri, 23 Oct 2026 14:30:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 894221F031E0;
 Fri, 23 Oct 2026 14:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792765825;
 bh=Lq9pw9llwfzBROAdKdKbXgd8474rxwyRgo57M5xeQoc=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date;
 b=ggaDYJL9awAaw+lPuQjig1r3GGVQ4ACJ1klruu0BtYbxQ5N35rTZoFuAg2Vn2Zy+9
 Pj6gNi7z/cBBUxGvbl08JC8DfWMXEV01ZayE8Bi/SkJ5c0dGGZdokXt2ptOxe+qmG5
 4U7Aqk/PX/taVe9hqagqZa7c1HsPRf/rx+0RMyysnlKZAJK0TEm7R+H75GnVVRpWi2
 MovJxXSlRayVgYkAYfxLifVkET/71CoIuDEbq3T3QktkOu84m7TO3XDOV57XGl00/y
 N9sjAL0yQwapK/NEQVTJLwTTEQZNp9RfDIoEruKLsFkmHt1wlDAq46tAViDTnD80vg
 Ucy9ENIPv6kZw==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, Simon
 Glass <sjg@chromium.org>, Shahriyar Jalayeri <shahriyar@byteray.co.uk>,
 Quentin Schulz <quentin.schulz@cherry.de>, Pengpeng Hou
 <pengpeng@iscas.ac.cn>, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Ahmad Fatoum <a.fatoum@pengutronix.de>, Guillaume La Roque
 <glaroque@baylibre.com>, Jan Kehren <jan.kehren@emteria.com>
Subject: Re: [PATCH v4 0/5] avb: device lock state, root key provisioning
 and in-place verification
In-Reply-To: <CAPzfCAYie5VhHEXvF3pzV60Nt52ypdjGuwVRXRehV7XdabDTOA@mail.gmail.com>
References: <20261022-upstream-avb_lock_unlock_b4-v4-0-f4926ca925e7@oss.qualcomm.com>
 <179275217876.886736.6937155990522210284.b4-ty@b4>
 <xhkdb1p9gps36.fsf@mkorpers-koolstof.csb>
 <CAPzfCAYie5VhHEXvF3pzV60Nt52ypdjGuwVRXRehV7XdabDTOA@mail.gmail.com>
Date: Fri, 23 Oct 2026 16:30:22 +0200
Message-ID: <xhkdbtsmco5fl.fsf@mkorpers-koolstof.csb>
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
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Igor,

On Fri, Oct 23, 2026 at 16:14, Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>=
 wrote:

> Hi Mattijs,
>
> On Fri, Oct 23, 2026 at 1:35=E2=80=AFPM Mattijs Korpershoek
> <mkorpershoek@kernel.org> wrote:
>>
>> Hi Igor,
>>
>> On Fri, Oct 23, 2026 at 12:42, Mattijs Korpershoek <mkorpershoek@kernel.=
org> wrote:
>>
>> > Hi,
>> >
>> > On Thu, 22 Oct 2026 21:04:41 +0200, Igor Opaniuk wrote:
>> >> This series completes the device state handling of the AVB 2.0
>> >> implementation when the state is kept by the OP-TEE AVB TA, and fixes
>> >> the way the Android bootmeth hands the boot images to libavb.
>> >>
>> >> Patches 1 and 2 add the shell side: "avb read_pvalue_hex" and
>> >> "avb write_pvalue_hex" provision binary persistent values such as the
>> >> SHA-256 digest of the vbmeta signing key that CONFIG_AVB_ROOT_KEY_TEE
>> >> consumes, and "avb lock"/"avb unlock" set the lock state through a new
>> >> avb_write_lock_state() helper. Until now U-Boot could only read the
>> >> lock state, so a device backed by the TA could never leave the unlock=
ed
>> >> (orange) state.
>> >>
>> >> [...]
>> >
>> > Thanks, Applied to https://git.u-boot-project.org/u-boot/custodians/u-=
boot-dfu (u-boot-dfu)
>> >
>> > [1/5] cmd: avb: add read_pvalue_hex/write_pvalue_hex
>> >       https://git.u-boot-project.org/u-boot/custodians/u-boot-dfu/-/co=
mmit/ae7f94107cf9a1a83799034b1e4165fe49e6d8a7
>> > [2/5] cmd: avb: add lock/unlock commands
>> >       https://git.u-boot-project.org/u-boot/custodians/u-boot-dfu/-/co=
mmit/08d45d705a740c63791441f4b8e0a612dddf15cd
>> > [3/5] avb: verify the boot images in the buffers they are booted from
>> >       https://git.u-boot-project.org/u-boot/custodians/u-boot-dfu/-/co=
mmit/5f6530505fdc0fc01f2df1363febc338fdfbf709
>> > [4/5] fastboot: add flashing lock/unlock/get_unlock_ability
>> >       https://git.u-boot-project.org/u-boot/custodians/u-boot-dfu/-/co=
mmit/c69982f9c9ec2b3f2d91dc9c49e9971f9fe3664a
>> > [5/5] doc: android/avb2: document the root key provisioning and lock s=
tate
>> >       https://git.u-boot-project.org/u-boot/custodians/u-boot-dfu/-/co=
mmit/2d105e34525ff9b0c3ee8c434781e5c9ff807b4d
>>
>> This series fails CI on sandbox_spl test.py:
>> https://git.u-boot-project.org/u-boot/custodians/u-boot-dfu/-/jobs/123953
>
> Yeah, my azure's sandbox_spl build
> (https://dev.azure.com/igoropaniuk/u-boot/_build/results?buildId=3D47&vie=
w=3Dresults)
> passed, but unfortunately, I tested it on the wrong base: U-Boot next
> plus Jan's v3 patches (which I rebased on),
> without Carlo's SPL fastboot patch [1], which recently landed in u-boot-d=
fu.

Ok, that also explains why I had some conflicts while applying. Please
note that Carlo's SPL fastboot series is already in main as well.

>
> I'll send v6 in an hour.

Thanks for the prompt reply, I appreciate it.

Regards
Mattijs

>
> [1] https://patchwork.ozlabs.org/project/uboot/patch/20260913-ccaione-ups=
tream-spl-fastboot-v6-5-dd3ba81a7ed2@baylibre.com/
>
>>
>> """
>> Building current source for 1 boards (1 thread, 16 jobs per thread)
>>    sandbox:  +   sandbox_spl
>> +drivers/fastboot/fb_command.c:302:13: error: =E2=80=98boot_image=E2=80=
=99 defined but not used [-Werror=3Dunused-function]
>> +  302 | static void boot_image(char *cmd_parameter, char *response)
>> +      |             ^~~~~~~~~~
>> +cc1: all warnings being treated as errors
>> +make[4]: *** [scripts/Makefile.build:272: spl/drivers/fastboot/fb_comma=
nd.o] Error 1
>> +make[3]: *** [scripts/Makefile.build:497: spl/drivers/fastboot] Error 2
>> +make[2]: *** [scripts/Makefile.xpl:552: spl/drivers] Error 2
>> +make[1]: *** [Makefile:2462: spl/u-boot-spl] Error 2
>> +make: *** [Makefile:189: __sub-make] Error 2
>>     0    0    1 /1              sandbox_spl
>> """
>>
>> Can you have a look please?
>>
>> If you resend a new version, can you also please rebase on u-boot-dfu ?
>> I had some conflicts when applying PATCH 4 (I fixed when applying but
>> i'd prefer to have a clean pick instead)
>>
>> Thanks
>> Mattijs
>>
>> >
>> > --
>> > Mattijs
