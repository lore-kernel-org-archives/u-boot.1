Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5873C606A321
	for <u-boot@archiver.kernel.org>; Thu, 26 Nov 2026 13:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=w2SbTWaP;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XzIhRpKS
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 209058116D;
	Thu, 26 Nov 2026 13:15:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tk21D1NyLbrq; Thu, 26 Nov 2026 13:15:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 410E68114E
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795698932;
	b=BClAB/8oOkESYF4WQaEMhxNY0oxaz/RF1T/I+o9gJwG810vbpl8MzS3Zf3cyAlFYgv+c
	 mVub6FbRoyjojv/z7HkCuPTjnUszw+zcqeYKlL/QXVFW/UcPBV4WI1b7Ker5LRY4MTovH
	 WVQzbBeW+sV8f2+bAW84q3Z9AhqMLdVQ/90zuKkM/FQCV4T7SIZRQO8aFUqo2/49tMG+t
	 7GcRSkeRPAUXoHZk0A1zX2BY+nEDF5WWsCIJRDIYOCeHvfJHoNP6FKfrxNzCXwyLXjLs+
	 PZseVJFW7Fca8AY3Tc27RVc8Vvej+NgoAV5U/Z503l+aObzlD5uFDUzAl9/cCHmd5oQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795698932;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:References:
	 Date:Message-Id:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=PsjDm5P1rP7zbw14bwXSXrAp8Mfpc+lz6l0QVCnSx5Y=;
	b=GaM+8bAfkWyq1myqEo4Y8E/vN2xC4CLnpuDFteRAktHEQfrUrnoaQtV7Dh1ebvH6ujxY
	 I0O0uzelw3ji9Do+kvUuOBMbHVPCo/oiVjZjda+LBiRmFGfD/NdTe58JF8z2gAzLIhqnM
	 NPuWHvnNu/iEjba2LYaMEvs63iybTBJujNhvtKU4Uo2I0dV3fvK90mSI4fpzAuQG5v/NW
	 N8fC7zENeEUI8jLRi4MGWUh7S049cNxGllKFnNqy/+Kou44N9/aLAqPsbmoILj1bXI7ld
	 eXyBGp+i4bf2k/M/TNkOh+UMXGv7t+9/uGBkYleZfJoPDtzowqlAy/+YueAe6+VFufA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795698932;
	bh=PsjDm5P1rP7zbw14bwXSXrAp8Mfpc+lz6l0QVCnSx5Y=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=w2SbTWaP9Id7hQZtPGpS+t36GhB+E1EpCOdMyJyJf6MXIqxHhbLX7CTpziDIDsRol
	 udxv4K8d16cwILVIe46qILcG6xnRbVOAoFqmi7C6hiTS+XcQULEdWO3GJoDkHMpiM/
	 MyxpDUmUEYIYFUySQT8jmsO0PKZt7jp3pixTx32GhIlYnof/EcG0igcJ2Q/pmEj5zi
	 EeTLQlWSwms5kKXyfMxtJIKz88yx/Knos9XJrM/Wg9rpTKdxQlTqAwU69v9N1ggh5L
	 hc4LF0vSty3ecVWs8hx5ETi3BzFKD4TzgXMRHZw+hs0JMKR2f0sbjTBlSwi/kEsHpv
	 tkr05gy+7INtg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 410E68114E;
	Thu, 26 Nov 2026 13:15:32 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 5E23C2DF
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 13:15:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 5BBD040935
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 13:15:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MRM3wO2NJI4J for <u-boot@lists.u-boot-project.org>;
 Thu, 26 Nov 2026 13:15:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 8D9A340880
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=172.105.4.254
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org; envelope-from=mkorpershoek@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=XzIhRpKS
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8D9A340880
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 13:15:29 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 1FE3A61B7F;
 Thu, 26 Nov 2026 13:15:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CC441F000C0;
 Thu, 26 Nov 2026 13:15:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795698927;
 bh=PsjDm5P1rP7zbw14bwXSXrAp8Mfpc+lz6l0QVCnSx5Y=;
 h=Subject:From:To:Cc:In-Reply-To:References:Date;
 b=XzIhRpKSkCg9AqwJ6nVrLM0WSgvq8pyaJ9p03+2CMYUmb9oV5XXyAwWGXILCjymGu
 7E5fFGYh6pfvxIpg48cQB++dDT4EMC9rn9ai2qP8+1aNYIi7KkK8FmmoEZTKSOMk+g
 WkPmRa+AhYvPNbzesn9yCiEF75ZKvQlenwusZrYfdZv4zZ+s26yVCKRH282KhSRhVO
 o25jY61M6w6pnXfqd9Rwjn0PRJ8gnqIO0Gi87dlnzMOxiAULCC2AVH8XxlI4g2BcE6
 S3389bG3lC5uR9hPJebnHAc0TZ3h14vvMaqbo2J9sqB6WNkXYmUzQVq3UWAMQqZjAl
 y1CLr8FkUNJiA==
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 00/14] Qualcomm Firehose flashing protocol support
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
Cc: Casey Connolly <casey.connolly@linaro.org>, 
 u-boot@lists.u-boot-project.org, Sumit Garg <sumit.garg@kernel.org>, 
 u-boot-qcom@groups.io, Tom Rini <trini@konsulko.com>, 
 Lukasz Majewski <lukma@nabladev.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Marek Vasut <marek.vasut+usb@mailbox.org>, Johan Jonker <jbx6244@gmail.com>, 
 Vitor Sato Eschholz <vsatoes@baylibre.com>, 
 Carlo Caione <ccaione@baylibre.com>, 
 James Hilliard <james.hilliard1@gmail.com>, 
 Jerome Forissier <jerome.forissier@arm.com>, Simon Glass <sjg@chromium.org>, 
 Mehmet Fide <mehmet.fide@screeningeagle.com>, 
 Vincent Jardin <vjardin@free.fr>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Michael Srba <Michael.Srba@seznam.cz>, 
 Biswapriyo Nath <nathbappai@gmail.com>, 
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>, 
 Daniel Golle <daniel@makrotopia.org>, 
 Rasmus Villemoes <rv@rasmusvillemoes.dk>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>
In-Reply-To: <CAPzfCAYacKZODn2aVBuEWLPw_iM=bbCkh3m8mEazRRg+C3yNvw@mail.gmail.com>
References: <20261106-firehose-v1-v1-0-e7591c12fc65@oss.qualcomm.com>
 <dabc31e4-3e1e-4b3b-9e2b-f69a7ebe52a7@linaro.org>
 <CAPzfCAYacKZODn2aVBuEWLPw_iM=bbCkh3m8mEazRRg+C3yNvw@mail.gmail.com>
Date: Thu, 26 Nov 2026 14:15:25 +0100
Message-Id: <179569892547.2171115.6508319764341313956.b4-reply@b4>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2994;
 i=mkorpershoek@kernel.org; h=from:subject:message-id;
 bh=1dabTNwnBA8oONZOCwcrwex17muh/HDx++eQkWS92ok=;
 b=owEBbQGS/pANAwAKARkNHbRmThk1AcsmYgBrCDDta4/YNYPxShWBrWNIjDhKhYUTB+p9hj7TV
 3bh6BTGorqJATMEAAEKAB0WIQQu6UKnth9qvlMTrQAZDR20Zk4ZNQUCawgw7QAKCRAZDR20Zk4Z
 Nd6WCADa++uQ1LoR0hjdutGZ8UoTj1lpm2KQ8pA+rwngy5KLBEz0r2lrl+6PjK1B5yFPVy4m/vk
 N84khYWlXQnkMjeFXSg5H+COtWdiUPkkxRJxbEV892VRyKCjbE15pIqGO75WHxqSknRGLYz6ybk
 V8clzf9Ro+ci2pdl15kwL7GxgAuzrAh/2h6CtRpHtmVw2fpgZWW/NEEfd61eQw87HOAiXomFGVr
 U4YFNXPQ95qi8ye7HhAVYczuwj09a+Gq7hRNsjK4vWDmrP7YVbG5kNA35YO4lupnhxoy/LMX9LZ
 rWwi9Uvo5D4k+36/nqqCgL3+IEyqaSSsL3cMJ+cTX1s7Q5WI
X-Developer-Key: i=mkorpershoek@kernel.org; a=openpgp;
 fpr=8234A35B45C0D26B31C1A2DA570338B018144F28
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 2026-11-06 23:56 +0100, Igor Opaniuk wrote:
> Hi Casey,
> 
> On Fri, Nov 6, 2026 at 5:56 PM Casey Connolly <casey.connolly@linaro.org> wrote:
> >
> > Hi Igor,
> >
> > On 06/11/2026 10:42, Igor Opaniuk wrote:
> > > This series adds a "firehose" command that serves a block device to a
> > > such tools as QDL [1]. Firehose is the protocol used to
> > > flash Qualcomm boards in EDL mode. With this, a board running U-Boot can
> > > be reflashed with the same toolset used for flashing any
> > > Snapdragon-based device.
> > >
> > > As discussed on the RFC [2], only the subset of the protocol needed
> > > for flashing is implemented, and the XML parser accepts only the subset
> > > Firehose uses:
> > >
> > > - configure, program, read, erase, patch, power (reset) and nop
> > > - physical partition 0 only
> > > - sector values N, NUM_DISK_SECTORS[-N] and CRC32(<sector>,<bytes>)
> > > - no VIP, UFS provisioning, getsha256digest or getstorageinfo
> > >
> > > Btw, work is ongoing to make the Firehose and Sahara specs public and
> > > community driven, so soon there will it will be available and used
> > > as a reference for host and device implementations alike.
> >
> > This is definitely an important point, is this implementation meant to
> > be compliant to a spec or to the existing tools? In either case, I think
> > there should be at least a high level specification either in the docs
> > or at a stable link we can reference.
> 
> That's the plan. We're finishing the move of QDL to the Qualcomm
> gh organisation. Once that's done I plan to start the legal approval
> process for the Firehose and Sahara specs, which are expected to
> be published in the same repo (of course, if the legal thing works out).
> 
> >
> > My other main concern here is maintainance, I'm happy to take these and
> > future firehose patches through the qcom tree, but I'd like to delegate
> > some responsibility for this. Could we get a new entry in MAINTAINERS
> > for firehose support so it's clear who will be reviewing and testing
> > patches?
> 
> Sure. In v2 I'll add a MAINTAINERS entry for Firehose with myself as
> a reviewer (I co-maintain QDL already, so happy to help here as well).

Yes, adding a MAINTAINERS entry for this would be great.

> 
> As for the custodian tree: Mattijs already has a lot on his plate with
> the AVB and A/B patches I've been sending him over the past month, and
> according to patchwork this series has been delegated to him as well.
> So I'll leave it to you and Mattijs to decide which tree suits Firehose
> best, as more Firehose-related series will follow.

Yes, as this is a a new USB gadget function, I thought it make sense to go
through my tree.

I do need ACKS from you, Casey, on 9/14 and 10/14 since those touch the
qcom defconfigs.

If you prefer taking everything through the qcom tree, Casey, that's
fine by me as well.

-- 
Mattijs Korpershoek <mkorpershoek@kernel.org>
