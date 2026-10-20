Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37F54606A322
	for <u-boot@archiver.kernel.org>; Tue, 20 Oct 2026 13:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=HcifkgCt;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BIpgHO8E
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0E7F68100F;
	Tue, 20 Oct 2026 13:09:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qnhRg_LTdvN1; Tue, 20 Oct 2026 13:09:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org BD8D8810AE
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792501748;
	b=gtZ5hL+d90bJKl1ZUH8DGBwgfB+L4WkL2RHVKIUgtNHpjFyxJF4+S7i7zUMzGeTprwoD
	 G71CcHSVCk1ZZDejdCEKVF4LtUbLIM5RbuyfabZDi2ALwMx094WBMknHX3nSTst2AWeJW
	 96MvLUdrOB8F6CheUMPYTLs3zkzLbuf/sFRuQO5uBICsO3yBB/XEh8jH38QFD1zmg/bw2
	 FrNa9FK4v7R5cctQ1Yd8JPJWTXoA+RlotY9DHC5NiL+6ueGiyCV13npXCIB+V1eUeTmhU
	 2v5H7g3qU5+siGTc5nuRO0X38xIjgu2THMLG2tkgkjNoCDRDUUiakg8HO1uaeIdYOlQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792501748;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:To:Cc:Subject:In-Reply-To:References:
	 Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=3Hu+BmQ4HHYFVdrBOUJ3eNzljPHVywiXF3D1DfJI6zs=;
	b=ORL4NYgAp8Gam94yjo3CBlIYrFDUcLQI4FGn89R4ZOL75gu2ki12z85EBKnxwggUqnrZ
	 7HPIiIFjNJwSr9ajpNSDALj3eOvAeA5SV/Pms88lX3tWj2ux3f/q2Rs579BLXAXUL6RtE
	 iVhXxxpL8rERAk8IRrJWwzKBHaKuMF1cGTugmkphE09Dit2+b6uQ6Igdh99OpuZAN0DgF
	 ZUPIlExbdHlmOnLqMQvfkRAvfVa7nSI3dx/kY6LG7lIrkmr2f9zB+reC95fwq58R1gysh
	 GtGun/ngXbGPCsuvobwrV2HhUaVw+47oJDUAKhFTrvmAvFEdgwrQhUHtNixU72G4rAQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792501747;
	bh=3Hu+BmQ4HHYFVdrBOUJ3eNzljPHVywiXF3D1DfJI6zs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=HcifkgCtiXqvray11Ol04negzK6mR06PDAZ8juC261USdNs1wjObo7avOeyvvkfsV
	 HfLd0gByAMcfM47TOJMz2gnbuUZnt1tmb6cP/Ay0HlBxlQ9nh4OicHYdpZipReIpFw
	 wzOIL/HSvDPOkD+Pv63yB8jomoq7vS2uq1rkBDqfXjOq84WWB4jg/N0y/QWhBZxyBC
	 DI63TfE03VDq1RukIpXRQ7pZ5L4LaRsl0U/sIgeKOAl5pM4tAmkfwu2fKjhAZ7flmq
	 JjCSwgJEAP72FN30cXJS4CffbS3+qG0NBaApDXmSSkL4FHmKb/VD0IKauweniNQCuy
	 qtVB/0OWf7JWg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id BD8D8810AE;
	Tue, 20 Oct 2026 13:09:07 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 7D1CC75
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 13:09:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1B38340786
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 13:09:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qcOLkVXuCb7q for <u-boot@lists.u-boot-project.org>;
 Tue, 20 Oct 2026 13:09:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org BB6D440976
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792501726;
 b=SY5X/rPlrk/8sM/W/k0Rc85o1NhbUZ3GuGw/HMUoqJEbhGxBU2JCxp/+LH0KPYNT8iA9
 ZqocnlFkO9xrnJjkyJd5YRcD+knKomHeSJ41bN7MOaaCtoRFf+h2Wrrlgu0XJ4qoHyMEt
 0TIgcddHPacWS1si8FWwmO4URTB76H7VfI54b+qMwUg3LYfbvrp4fCcSA6J7q06dWxIf9
 keJoozCYc8ryaiEwv8Q4WQiTfRkXRDMzXNXKMdUExqkw/Vlf+s9CDtn30s0wxGX50x60Y
 r9CyNLUyHHpDJp1GUZ/UJeC92Aw8Xy5EYLX4/eRIttIcWbsVAW+BFCE0mLhc3OwGKzg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792501726;
 h=Received-SPF:Received:Received:DKIM-Signature:From:To:Cc:Subject:
 In-Reply-To:References:Date:Message-ID:MIME-Version:Content-Type:
 Content-Transfer-Encoding;
 bh=3Hu+BmQ4HHYFVdrBOUJ3eNzljPHVywiXF3D1DfJI6zs=;
 b=EnfqeT/CZJ/nrR4Ihk4qM/dJD9s2vDWfl97xmF1G0NNXX7tmSYIfDLuIdGZathysVE1K
 IRO1UosEHQDW/rmtTajSShIvAIWMAccFWQoEAYHqTqF9UberbNp7IPAnRnRmFSE4xEawD
 EptMmG9ccW0BCamgFMy1GeOJziN/7Ekc3m8c4lSXzpxvbTCu9udmHMvxVrPeun4TlUItU
 bemxx1tIIWJxAz7xEVPUjyTQMwnyM44j3Pj1WgDQka2nFs+MnD5TAFBjhq4mSv8AJM1yz
 zVINSrKYo+ihQOjyGakAXFibCeJU/5ZXSt+59v2SdsVRm8Z2irtbnflyf/1P4FjtkPQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=BIpgHO8E; 
 arc=none smtp.remote-ip=172.105.4.254
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org; envelope-from=mkorpershoek@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=BIpgHO8E
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp4.osuosl.org (Postfix) with ESMTPS id BB6D440976
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 13:08:44 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 8CEC260052;
 Tue, 20 Oct 2026 13:08:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6AB61F000C4;
 Tue, 20 Oct 2026 13:08:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792501723;
 bh=3Hu+BmQ4HHYFVdrBOUJ3eNzljPHVywiXF3D1DfJI6zs=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date;
 b=BIpgHO8EO3s4P7OpDvcQXACy0u9TYmoef7lbDPq+rAZ8RhyI+lww1F0crpqMdvQvq
 OABaOZWNFMEbBc0cQF8l53M6viol9CzV2tNKT3rDb/sNlAnbNLcXiIdf0WBf1qI1gj
 mr1I7mRa06QcFm4G5duvhH5+Ug9XHwZ9OFDTFbooG7QCtL1o/9OL6qve6u4sqUv6yd
 iku9CVKwUyNOmgkOB5HSQRm4/DQ5Kx27x4YFhz/Wr/DdDlndwCJkxvrv5sIQcAJaoV
 AbM7rgimQs9FCo7CSmObf5W4m+8bz6mw7D1fFWUZPgSpRO0kxv0EEmAlOwgLrIYtg0
 s/K3qMU7zI7xQ==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
Cc: Jan Kehren <jan.kehren@emteria.com>, u-boot@lists.u-boot-project.org,
 glaroque@baylibre.com, sjg@chromium.org, trini@konsulko.com
Subject: Re: [PATCH v3 3/3] avb: Take a storage interface in the AVB operations
In-Reply-To: <CAPzfCAash-859YOP34C=BWq_znN2CWxvAPvLmy0yREzwT5pAWw@mail.gmail.com>
References: <20261006092732.3577974-1-jan.kehren@emteria.com>
 <20261016072640.772964-1-jan.kehren@emteria.com>
 <20261016072640.772964-4-jan.kehren@emteria.com>
 <xhkdb8q3s4mxe.fsf@mkorpers-koolstof.csb>
 <CAPzfCAash-859YOP34C=BWq_znN2CWxvAPvLmy0yREzwT5pAWw@mail.gmail.com>
Date: Tue, 20 Oct 2026 15:08:41 +0200
Message-ID: <xhkdbwlrc34fa.fsf@mkorpers-koolstof.csb>
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
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Igor,

On Tue, Oct 20, 2026 at 14:57, Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>=
 wrote:

> Hi Mattijs,
>
> On Tue, Oct 20, 2026 at 1:43=E2=80=AFPM Mattijs Korpershoek
> <mkorpershoek@kernel.org> wrote:
>>
>> Hi Jan,
>>
>> Thank you for the patch.
>>
>> On Fri, Oct 16, 2026 at 09:26, Jan Kehren <jan.kehren@emteria.com> wrote:
>>
>> > AVB assumed its partitions were on mmc: avb_ops_alloc() took a bare de=
vice
>> > number and get_partition() called find_mmc_device(), which rules out
>> > verified boot from anything else.
>> >
>> > The user that benefits is "avb init", where boards already expect to n=
ame
>> > an interface: board/armltd/total_compute/total_compute.env picks betwe=
en
>> > virtio and mmc at runtime and then runs "avb init ${blk_dev} 0", which=
 no
>> > release has ever accepted. bootmeth_android gains nothing yet, since
>> > android_check() rejects non-mmc bootdevs through bootflow_iter_check_m=
mc().
>> >
>> > Carry a uclass id alongside the device number and resolve the block de=
vice
>> > with blk_get_devnum_by_uclass_id(), keeping mmc_init() and the hardware
>> > partition switch on the mmc path only. "avb init <dev>" still means mm=
c,
>> > "avb init <interface> <dev>" selects another bus, and neither touches =
the
>> > device: it is still resolved on the first partition access.
>> >
>> > Only mmc is started by AVB itself, so say that in Kconfig and avb2.rst.
>> >
>> > Signed-off-by: Jan Kehren <jan.kehren@emteria.com>
>>
>> Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
>>
>> > ---
>
> Hi Mattijs,
>
> A bit off-topic: it looks like this patch series will land soon, so
> should I rebase v3
> of "avb: device lock state, root key provisioning and in-place verificati=
on",
> which I'm about to send, on top of this patch series?

Yes, if you can rebase on top of this series that would be great!

Thank you.

Mattijs

>
> Best regards,
> Igor
