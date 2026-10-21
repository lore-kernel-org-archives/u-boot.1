Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6914606A322
	for <u-boot@archiver.kernel.org>; Wed, 21 Oct 2026 12:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=uD5aBcxz;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ADgr5X+E;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=afgr35Z+
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8E2A860A95;
	Wed, 21 Oct 2026 12:50:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vF6VN9IyB0AQ; Wed, 21 Oct 2026 12:50:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 751EC605ED
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792587033;
	b=Z7XCujdme5IKtwi+4y28htSQaiJABXe5qB/w7aDIE6o6igsJdwa0L+ewslty6diA3du5
	 llgZO2Qn2QOagc2DUnFXdcvDgpkH49JzxCXE+tzHKn5sMy/jUfc+9ysfP3LXuNQmNVdQm
	 fgvYGLn3FPRhAIsTG6TCOMCbicLAcx2IVuRKRXpC84fLuebB6aFwAMbbK77Bbw5M+hFTD
	 iSChTB8XFyh3oQwME0IY++DaDJ6MQH3MDYseU9dBic271DcFBeHmRVhRBENW/mhkWvim3
	 4bPYNAV0uw9QB8edQbKV/19HSDz/EcPyJxZLkZgqvtKkhCikA4AXEt+DOOj/J97gc3Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792587033;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=TBPqcKi03CpR8orfMGKKmZnZsVMLSRjZdC2v7y4Z6Pg=;
	b=lJJ7DzEz8tSk+1HHetyAQWY+ryaA6hrpVM9ggZfb7n+mS7uPsKaX58u0M3OFAxe+UyIw
	 se2wVd/QX3pWU5e77IXxzc619Yammfucv0kxtF4aWrj+A7pVkOC9nQtb4RfiYXo4ZLQJi
	 k7n+v6+0XHjYBTBwwULHjWVE4IeR+epsnhYz3AUjvs4KpS26J2wXNpfKZEPpAtaEu2BFd
	 7cLLpc5mPAwSh5tM+1VtmhJJHL+j6zwqDCJ1SMFSoo4kmuG+h8WQev4jLQImWF5BJFNaa
	 C7My/86bRybvek+nAmH9DmBROptiAx1i2Dz/rsOAkG4kxIWiEbGTb17ixeuT3LFD8Dw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792587033;
	bh=TBPqcKi03CpR8orfMGKKmZnZsVMLSRjZdC2v7y4Z6Pg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=uD5aBcxzYCBUlSLx/DvW7y109pvaomSUYnpysf64HwF/sUqdIk3LQWo8C5hdDMMYC
	 C0eO4BzIxUdEFP6CEKbt5PF5u/GYlhl9TBMuu8w07yEhgrfxuVkTLQsh5nLGhF7mX8
	 MQV3wkFlzfyRdH4Pbw53RjXffsaNhBjk5SC9c5EAqVMBBgE4A4tgHvX2IszYjFlThJ
	 zF9j7mmln6LBlo5h3BuZgB9mqpnZKIpu7uuUIZcAznUW9wKHEENpU7Dkw1SZoIjEK2
	 f99igJNTnJTVS2z7y5CHf4JkTSOqtYgJBrrniwVQTgP+QdODqlTKIpqD+uHzfp6eln
	 H9urb99OTJEhg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 751EC605ED;
	Wed, 21 Oct 2026 12:50:33 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 0A2F31AB
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 12:50:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id F073340877
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 12:50:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id v_XrLbyqDLK9 for <u-boot@lists.u-boot-project.org>;
 Wed, 21 Oct 2026 12:50:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 0710540866
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792587031;
 b=sJKedoCb8uhrZnoMea5r7v3vtjDndw4PBfqiNIUHM0OtaTkvTnS1nNJdspJkiMY8eyNx
 WDWI0wn3dHaXUtwVYKLsvbqxT2VoLEYg7x3u1zLiMQ/3Q/rNUdb98hkHjfmQbWutAXXct
 ewurtdugVUy4tdkbZimQCPloaNL8hxpIDp6XWJbe6DPkjZ91loacImxO7vRHPD+IH9uSl
 mvRuxc7ZtEnKa6pcAS7+wb0PbPNzrRlCz4t0Xb80yigfRtxOVqGTv1GJWO9/RPfp98TB9
 6xDrNQtsG/1eH6IM4eyV5/92QZtH2ZVrZocp+ePZOs2Lde9d30BOGTK/826s9yk7qvg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792587031;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
 X-Received:X-Received:Received:From:To:Cc:Subject:Date:Message-Id:
 X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:
 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=TBPqcKi03CpR8orfMGKKmZnZsVMLSRjZdC2v7y4Z6Pg=;
 b=NejscFwPp/QLfsgAtAj33I7N2hGeC5kX0/fKWkGg7Y3k6tF2Hjtq0h8EfSfKWCOMcitL
 p+rGdc/QEQyTTF6PPG0Tx2kyLhEs5kZCk1xjrat7TA7Y4xft0vsj2n3x17XQef2KuN8Rs
 8Lskz158LnJ+OHX0/+EExxCmn3wnbDV883Rmz0Dg3/iZw//Fjp99ZBEKPbdCdoPZfEwXs
 drw5ATDxWOhGX44zARP7TkoDKbE3Kvmfcehu+gFusU7LK09GJEy39rTkAXDEXaeYx1X1w
 V/Nlk745OZ7OwEjhrKNtZNIatM4X2yjf77/6b8vk9elG+P2xZNZiexyXGILW5t5V2sg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=ADgr5X+E; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=afgr35Z+; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com;
 envelope-from=gurumoorthy.santhakumar@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=ADgr5X+E; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=afgr35Z+
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 0710540866
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 12:50:30 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69LBg4KG544076
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 12:50:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=TBPqcKi03Cp
 R8orfMGKKmZnZsVMLSRjZdC2v7y4Z6Pg=; b=ADgr5X+EIput3eM/PkNjPpeC6d4
 8irdJsnqj2AcBr0Ypx+cwtR/H5f3Dn0k85KwiGeoLWiUNOmEuVm4e0KEzkbAVPCH
 m407+RZr3MJ5gqqK4qEC4wcJXGz+WG9kljzRar+0sg9M1++wtHtDYzB2g3Lyi2XT
 3B+9lzrbhlmaQx6DJm6VVcu2XpltIChozomXzYypiZqKY76AcH/GqueXArno6IRs
 hIXhFV4JDwHoxR3veVxAXE2oR4lD8Ru5yJLbTmw/0HVv93sBuOJGK3Je58YbOaPZ
 fS9DSiD2sNLfQeJ1di8/M8ahSStrjEXphmW75vi+Nkq0KwBTP6QYgyw/6mw==
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hetj48rf2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 12:50:30 +0000 (GMT)
Received: by mail-dl1-f71.google.com with SMTP id
 a92af1059eb24-16bc6f3fdb1so785099c88.0
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 05:50:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792587029; x=1793191829;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=TBPqcKi03CpR8orfMGKKmZnZsVMLSRjZdC2v7y4Z6Pg=;
 b=afgr35Z+hsSXyQAm3Shvnx1MPneZYb1mateHcyt3OaKDViTvkFSTnV2ksF79kSCqM+
 4WOzW5m6p7qI1AbQExV0YmC7eN7nZ1ZeV+10qEJaeTTeU+eQpyFolUiGt0YYfOhOz225
 EhAD4OLb/TcDY48WITRhV2aQ1OfniWe5bkfS95IZt/P0NUJmV5gUBhoT2mSknIROLI5m
 dOiPxPtHjqSgSYMReao956RCk8C0ZHfXiYE1Pr/KWjyV8v6IMYA6cT8wF7OShLBQsHBc
 NBHwziEuDhleMvn5RsjNNtbLp86Ye8OCtCuslTXGNY/K3dlNX2YeM0AJXPxyQ6IiP3k3
 ndMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792587029; x=1793191829;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=TBPqcKi03CpR8orfMGKKmZnZsVMLSRjZdC2v7y4Z6Pg=;
 b=VzXdn22vKQuG+JK0uL3Amf8S/CeHif6LHJwOSR6RscoWCTqTlr55A8xaJqUJATGWEs
 +XDF9vuylHIZDpBVxeCqhdK5Dc17Xx4lAg0YgPhMcemGVWfiL0w4wG6jiC3G3U41dzTi
 /FS459pipXXFIBKf9FmA6et1sqJFyHTsrCBvasK8oiiMdMzDCMejPjMQ44WGARqvS1k3
 Dh0R9gdJtLGf5H3Y+pO1HPr+BRJakyIbLpgPp+i+ITFyP+eXIwIY+ygg7ochiJ1wFBmX
 oZzKvYWpDDZ2FDSB1nAcYDnqS3tZMr7VfiE6pybLc1FjyS4Gb0lVmuC70dNaAia64Nzt
 frCg==
X-Gm-Message-State: AFq9FYL3R9sX51YSQ00+HzN5cjPyGsZalAjVEfdiB2Egwdcj0J3tmf69
 /urGHbVC4x/+VRm0cs3cPmpgK46FVvWqol0rzVDM3DtDgJ+EYpkU+sAzYVCapZp+msGlbxfFzH4
 GTqh7S9BFrRyscunJweHZdADvnrf/KVDCqpbQYfg+b1hMAUumJmgR++ovM6w6l7f0oWf5b/KeJp
 MtFaE=
X-Gm-Gg: AYBFou0mPAKySbCl+C9GGxEXfUeGlrw85F/rJTO0qIFSKAmc7g0Zch6LQV8GTRUY4k7
 TUf1zcATluZpmkAx9DtmRZQdrE7BlRQ04PPn/rvPbaFXwErjs12M4fWH5Xm9uHWxlUbl6H0Qrek
 PGddu1o4GbQxOPxqZquLJhK9HVUijQyL5hw+RZYPqg5hNS0EuV9mZ3JrFXfur2/ciDv97WlOzlS
 j26YZ9H3wJOVa6RkGfSORxoEzN68bAoTkaXvgbe5mZW7DsJ9f/3EIqqcrVmuVhxg5jFYm3SBqLi
 JGrSy47zbk17FlTtWrR3w3kbuNHbgn30WjdZyLY/+LnthlD8ng1/42yzpnYtWYiNtNZ9IRtMD1G
 rFRane7MBgKeWpT6pj+rSp/X4lWuJqqlq3oDAUp6ZXPVrrkooU+pjJ5wofn2oKnqz3A1To5Apxs
 KosP8lXcjYtvhn3R0eBwVk3T7kLuWWIRsY4ZY=
X-Received: by 2002:a05:7022:7e86:b0:144:e38d:8e52 with SMTP id
 a92af1059eb24-190a784c70emr2725131c88.37.1792587029162; 
 Wed, 21 Oct 2026 05:50:29 -0700 (PDT)
X-Received: by 2002:a05:7022:7e86:b0:144:e38d:8e52 with SMTP id
 a92af1059eb24-190a784c70emr2725083c88.37.1792587028432; 
 Wed, 21 Oct 2026 05:50:28 -0700 (PDT)
Received: from hu-gsanthak-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1903aff3481sm6467815c88.10.2026.10.21.05.50.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 05:50:27 -0700 (PDT)
From: Gurumoorthy Santhakumar <gurumoorthy.santhakumar@oss.qualcomm.com>
To: u-boot@lists.u-boot-project.org
Cc: u-boot-qcom@groups.io, trini@konsulko.com, ilias.apalodimas@linaro.org,
 peng.fan@nxp.com, jh80.chung@samsung.com, sjg@chromium.org,
 Michael.Srba@seznam.cz, Varadarajan.Narayanan@oss.qualcomm.com,
 balaji.selvanathan@oss.qualcomm.com, aswin.murugan@oss.qualcomm.com,
 Gurumoorthy Santhakumar <gurumoorthy.santhakumar@oss.qualcomm.com>
Subject: [PATCH v2 4/7] i2c: geni: Add 32MHz clock support
Date: Wed, 21 Oct 2026 18:20:00 +0530
Message-Id: <20261021125003.2948090-5-gurumoorthy.santhakumar@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261021125003.2948090-1-gurumoorthy.santhakumar@oss.qualcomm.com>
References: <20261021125003.2948090-1-gurumoorthy.santhakumar@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: XJPuY-sW9YABNDpb0GjZNjPofswkUc1e
X-Proofpoint-GUID: XJPuY-sW9YABNDpb0GjZNjPofswkUc1e
X-Authority-Analysis: v=2.4 cv=N768hG9B c=1 sm=1 tr=0 ts=6ad8b516 cx=c_pps
 a=JYo30EpNSr/tUYqK9jHPoA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=jzqoRCIIP4o4-ZVpYiUA:9 a=Fk4IpSoW4aLDllm1B1p-:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDA1MSBTYWx0ZWRfX1TXgMOfpPUdN
 vJKn5IAaQAtnbBeE/Pe8BcJ7gDYROO4htS/tP54/S4GxE+8G5F53Cku5Jv22QZoKytsLAD+bjl/
 JHhXQymcfwi5mevtzRhQgGmKcNQqTV/FTcZcp9GPKASeiuC4WIIEEoNuNIJEPEWlhrWFKpEznL+
 V8Xl40gRs/t9rkBk7WP/RawxiFM4E3pw6SkIcTrlP6Q0PA+8cv6HjSltv8zJ1IpFI8VrgANSbG4
 /yQkVr6bKcgtGXCpnyzEpsvCyjjOaj6CWbB0qvi/66PrAVPIZee+xASOigdiH+ZY3/QuukBKTyW
 SQjArDmlGmj90Ufl7nVMCNPnKMK1LV+/AiuHyFlYIy0HfqdSh2b6lUD/reOvEdBh+eqWQMBVNKG
 Lpf6dclcbSAKFD8TkNcTRUs2IKO757FC8EH/ZNM5f1GijrlRSjneK4z2vVzLwJM/thqUshiSV7a
 Wc8bxPZVdkPHZ5AruaA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDA1MSBTYWx0ZWRfX/SeqGBbktYBl
 TbBs9pWpdM7ophUMX1PJzK/WcbF0hmGUCmXA86x5OxextJJGZK1Ip+xqt3ZB9m9wQ2D9Seq91vE
 mABGvryhN/NjZP4TiB9YxlxhAfQ5SjU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-21_03,2026-10-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 malwarescore=0 suspectscore=0 phishscore=0
 bulkscore=0 adultscore=0 impostorscore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610210051
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add the 32MHz GENI I2C timing table and select timing values based on the
effective serial-engine clock rate.

Depends on: misc: qcom_geni: Add minicore support

Link: https://lore.kernel.org/u-boot/20261005-spl-v10-1-c4ca29bf27ed@oss.qualcomm.com/

Signed-off-by: Gurumoorthy Santhakumar <gurumoorthy.santhakumar@oss.qualcomm.com>
---
 drivers/i2c/geni_i2c.c | 28 ++++++++++++++++++++++++----
 1 file changed, 24 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/geni_i2c.c b/drivers/i2c/geni_i2c.c
index c6d0d4f206d..15bfe640f59 100644
--- a/drivers/i2c/geni_i2c.c
+++ b/drivers/i2c/geni_i2c.c
@@ -96,18 +96,38 @@ struct geni_i2c_priv {
  * clk_freq_out = t / t_cycle
  * source_clock = 19.2 MHz
  */
-static const struct geni_i2c_clk_fld geni_i2c_clk_map[] = {
+static const struct geni_i2c_clk_fld geni_i2c_clk_map_19p2mhz[] = {
 	{I2C_SPEED_STANDARD_RATE, 7, 10, 12, 26},
 	{I2C_SPEED_FAST_RATE, 2,  5, 11, 22},
 	{I2C_SPEED_FAST_PLUS_RATE, 1, 2,  8, 18},
 };
 
-static int geni_i2c_clk_map_idx(struct geni_i2c_priv *geni, unsigned int clk_freq)
+/* source_clock = 32 MHz */
+static const struct geni_i2c_clk_fld geni_i2c_clk_map_32mhz[] = {
+	{I2C_SPEED_STANDARD_RATE, 12, 9, 10, 26},
+	{I2C_SPEED_FAST_RATE, 4,  3, 9, 19},
+	{I2C_SPEED_FAST_PLUS_RATE, 2, 3, 5, 15},
+};
+
+static int geni_i2c_clk_map_idx(struct geni_i2c_priv *geni,
+				unsigned int clk_freq)
 {
-	const struct geni_i2c_clk_fld *itr = geni_i2c_clk_map;
+	const struct geni_i2c_clk_fld *itr;
+	int array_size;
 	int i;
+	ulong se_rate = clk_get_rate(&geni->se);
+
+	if (se_rate == 32000000) {
+		itr = geni_i2c_clk_map_32mhz;
+		array_size = ARRAY_SIZE(geni_i2c_clk_map_32mhz);
+	} else if (se_rate == 19200000) {
+		itr = geni_i2c_clk_map_19p2mhz;
+		array_size = ARRAY_SIZE(geni_i2c_clk_map_19p2mhz);
+	} else {
+		return -EINVAL;
+	}
 
-	for (i = 0; i < ARRAY_SIZE(geni_i2c_clk_map); i++, itr++) {
+	for (i = 0; i < array_size; i++, itr++) {
 		if (itr->clk_freq_out == clk_freq) {
 			geni->clk_fld = itr;
 			return 0;
-- 
2.34.1

