Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 594E8CD6E55
	for <u-boot@archiver.kernel.org>; Sun, 31 May 2026 21:15:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BCF0F840ED;
	Sun, 31 May 2026 23:15:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=valla.it
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=antispam.mailspamprotection.com header.i=@antispam.mailspamprotection.com header.b="dcPE+YN3";
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=valla.it header.i=@valla.it header.b="O7WxsHZA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B6D9484671; Sun, 31 May 2026 23:15:41 +0200 (CEST)
Received: from delivery.antispam.mailspamprotection.com
 (delivery.antispam.mailspamprotection.com [185.56.87.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BA217838D7
 for <u-boot@lists.denx.de>; Sun, 31 May 2026 23:15:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=valla.it
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=francesco@valla.it
ARC-Seal: i=1; cv=none; a=rsa-sha256;
 d=outgoing.instance-europe-west4-8rzb.prod.antispam.mailspamprotection.com;
 s=arckey; t=1780262138; 
 b=oq8lvHJHWiSJsQxpR74bMYcGQoG9R2ygX1QeQFWFYDDlssGiTTJB3AZVoYPrt9l4LNucFQlO9E
 LilLrMAEzBH85lGNQbMNU2lXUA7hOksyV5XrrDxk+tacSuNrG2pZf9mnQlOZoFA+nlADtjRiYF
 w4Ql/HENu2eE9BGoRjAZrXR7mlAgvqHl0FL3vUFcsmyi0p0AMnFbXCHRFX5DS8Jl2XXMQ3vQpD
 EyOmFae0N79xVyaJWU/gIZ8rwxeWcWaBJ8+id4gnCGRv5F5RSiNHlg3exCEJ51YOxWbbs0LKPj
 mPHRdqTO3DQvQV6NsJSg7jzk5tDbRUJ8C5614XbbwPPqfA==;
ARC-Authentication-Results: i=1;
 outgoing.instance-europe-west4-8rzb.prod.antispam.mailspamprotection.com;
 smtp.remote-ip=35.214.173.214; 
 iprev=pass (214.173.214.35.bc.googleusercontent.com)
 smtp.remote-ip=35.214.173.214; 
 auth=pass (LOGIN) smtp.auth=esm19.siteground.biz;
 dkim=pass header.d=valla.it header.s=default header.a=rsa-sha256;
 arc=none
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed;
 d=outgoing.instance-europe-west4-8rzb.prod.antispam.mailspamprotection.com;
 s=arckey; t=1780262138; 
 bh=I7pTrp+MN3eZjP5VHOwYQ2rH5bUqSQ9Wg9ttm8rAhkE=;
 h=Cc:To:Message-ID:Content-Transfer-Encoding:Content-Type:MIME-Version:
 Subject:Date:From:DKIM-Signature:DKIM-Signature;
 b=j2fm/z+EbJCpyPRO8gIuu5HJeoEJpjuUg/cJ8aOLouawz8KYHj5us9EZ/Gymufm0zvNiwH1mSH
 B4kafv+rEYpYW6iyWFWvuqN9zuP7sEKXdCvE5oCrXLy9lsClaTQerkVigCADW+nA6jiQKYf/zq
 LiHGlBWFxBWnj34864ldtnjELE1NWT47K/qECAN0DwhmX195+xKG0AhabPP3OS5A1Gf5A7MW+Q
 g87ArQig/b0lfZxVIxhMl+d/UAXKK2fuO7ewPZcSALz26VCi2B0cfXfb45OJw5hSeN5bJazMnf
 jxUNONenfvG75fx9oVgsV7CyX7ApXjEiUqtXXvqxPfvYoQ==;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=antispam.mailspamprotection.com; s=default; h=CFBL-Feedback-ID:CFBL-Address
 :Cc:To:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject
 :Date:From:Reply-To:List-Unsubscribe;
 bh=AXyjVqMZQUu2qqGgQ3E26gypXKVs50DDJBoAOB+JNpc=; b=dcPE+YN3s6+Z0Xn9AqYHeQv/ny
 WkWTOVXyydfqWEKiGpy2BliXJtiPOFqCGKfa0hR1IQcwvBy0hJZ0KKIL5XgPH9V7cnSqKpZJK3UVh
 GsCd+R8B2WSVi+h5/rUjydBU+4fxV8N6xpvI/vOcYb7zP8Zi2lfmP39QdAutNDnpIQPI=;
Received: from 214.173.214.35.bc.googleusercontent.com ([35.214.173.214]
 helo=esm19.siteground.biz)
 by instance-europe-west4-8rzb.prod.antispam.mailspamprotection.com with
 esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384 (Exim 4.99.3)
 (envelope-from <francesco@valla.it>) id 1wTnVP-00000001tvL-2Dmm
 for u-boot@lists.denx.de; Sun, 31 May 2026 21:15:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=valla.it;
 s=default; h=Cc:To:Subject:Date:From:list-help:list-unsubscribe:
 list-subscribe:list-post:list-owner:list-archive;
 bh=AXyjVqMZQUu2qqGgQ3E26gypXKVs50DDJBoAOB+JNpc=; b=O7WxsHZAVhT2CudFknP5LSznWd
 kGkntdfnC6Ee8WycuWX7fnORZtMcwecp+VOT6ER5lO5vrtgTt+BRSW/Y1R13JjF2E1cHxTPFbHBD8
 Oo1rviJfEeGtz5SwZb/mUDhUEzJ/hGm7PEKyDzaznhEPpGyS7aKNScpwP30IuhMOvy+M=;
Received: from [87.16.13.209] (port=60727 helo=[192.168.178.43])
 by esm19.siteground.biz with essmtpa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.99.3) (envelope-from <francesco@valla.it>)
 id 1wTnVJ-00000000Po7-3Ngr; Sun, 31 May 2026 21:15:29 +0000
From: Francesco Valla <francesco@valla.it>
Date: Sun, 31 May 2026 23:15:09 +0200
Subject: [PATCH] tests: fs_helper: check path validity during cleanup
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260531-test_fs_helper_fix-v1-1-f32da24de827@valla.it>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMWwqDMBCF4a3IPBvIBVvpVooETU/qlGIlE0UQ9
 27aPn4Hzr+TIDGEbtVOCSsLf6YCU1cUxn56QvGjmKy2F904ozIk+yh+xHtG8pE31dtWh2ica6+
 aynFOKPMveu/+lmV4IeRviY7jBOoAWHx2AAAA
X-Change-ID: 20260531-test_fs_helper_fix-a280cf133870
To: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, 
 Christian Taedcke <christian.taedcke@weidmueller.com>, 
 Francesco Valla <francesco@valla.it>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2449; i=francesco@valla.it;
 h=from:subject:message-id; bh=I7pTrp+MN3eZjP5VHOwYQ2rH5bUqSQ9Wg9ttm8rAhkE=;
 b=owGbwMvMwCX2aH1OUIzHTgbG02pJDFkyS16LJrtoXU9f3cNaY6jvMtd7/p3c6T1LfvxO/Wky4
 eKymF9cHaUsDGJcDLJiiiwh627c2zPX/FvaBsZHMHNYmUCGMHBxCsBEIlcw/K+Q2NIt+PSpbsRB
 B4csv7Stnx6Gzfebkq15NnnSO4vfbLcZ/inO1CqJfWS67cbXi2sTvU9vez5DXk+h4EqDMQfrO4d
 DL/kB
X-Developer-Key: i=francesco@valla.it; a=openpgp;
 fpr=CC70CBC9AA13257C6CCED8669601767CA07CA0EA
X-AntiAbuse: This header was added to track abuse,
 please include it with any abuse report
X-AntiAbuse: Primary Hostname - esm19.siteground.biz
X-AntiAbuse: Original Domain - lists.denx.de
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - valla.it
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-SGantispam-id: 6f8a3b3d4029f43afa8e5f48a03ef973
X-AntiAbuse: ID - 6f8a3b3d4029f43afa8e5f48a03ef973
AntiSpam-DLS: false
AntiSpam-DLSP: 
AntiSpam-DLSRS: 
AntiSpam-TS: 1.0
CFBL-Address: feedback@antispam.mailspamprotection.com; report=arf
CFBL-Feedback-ID: 1wTnVP-00000001tvL-2Dmm-feedback@antispam.mailspamprotection.com
Authentication-Results: outgoing.instance-europe-west4-8rzb.prod.antispam.mailspamprotection.com; 
 iprev=pass (214.173.214.35.bc.googleusercontent.com)
 smtp.remote-ip=35.214.173.214; 
 auth=pass (LOGIN) smtp.auth=esm19.siteground.biz;
 dkim=pass header.d=valla.it header.s=default header.a=rsa-sha256;
 arc=none
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

If the filesystem creation attempted by the FsHelper class fails, the
invocation of the cleanup function will cause a TypeError exception,
because the path of the filesystem itself, fed to os.remove(), will be
None. This will lead to a test failure even in case a skip is instead
wanted.

Such an exception will lead to a backtrace like this:

  test/py/tests/test_fs/conftest.py:269: in fs_obj_basic
      fsh.mk_fs()
  test/py/tests/fs_helper.py:70: in mk_fs
      self.fs_img = mk_fs(self.config, self.fs_type, self.size_mb << 20,
  test/py/tests/fs_helper.py:246: in mk_fs
      check_call(f'mkfs.{fs_lnxtype} {mkfs_opt} {fs_img}', shell=True,
  /usr/lib64/python3.14/subprocess.py:420: in check_call
      raise CalledProcessError(retcode, cmd)
  E   subprocess.CalledProcessError: Command '<...>' returned non-zero exit status 1.

  During handling of the above exception, another exception occurred:
  test/py/tests/test_fs/conftest.py:272: in fs_obj_basic
      pytest.skip('Setup failed for filesystem: ' + fs_type + '. {}'.format(err))
  E   Skipped: Setup failed for filesystem: ext4. Command '<...>' returned non-zero exit status 1.

  During handling of the above exception, another exception occurred:
  test/py/tests/test_fs/conftest.py:277: in fs_obj_basic
      fsh.cleanup()
  test/py/tests/fs_helper.py:91: in cleanup
      os.remove(self.fs_img)
  E   TypeError: remove: path should be string, bytes or os.PathLike, not NoneType

Fix this by checking if the variable containing the filesystem path is
valid before attempting to call os.remove() on it.

Fixes: 3691b1e4ce074 ("test: Convert fs_helper to use a class")
Signed-off-by: Francesco Valla <francesco@valla.it>
---
 test/py/tests/fs_helper.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/test/py/tests/fs_helper.py b/test/py/tests/fs_helper.py
index ee779474ce60..e3824b2c1fdb 100644
--- a/test/py/tests/fs_helper.py
+++ b/test/py/tests/fs_helper.py
@@ -87,7 +87,7 @@ class FsHelper:
         """Remove created image"""
         if self.tmpdir:
             self.tmpdir.cleanup()
-        if self._do_cleanup:
+        if self._do_cleanup and self.fs_img:
             os.remove(self.fs_img)
 
     def __enter__(self):

---
base-commit: 30b77f6aa146c96b831cb4ece038130b655b6a41
change-id: 20260531-test_fs_helper_fix-a280cf133870

Best regards,
--  
Francesco Valla <francesco@valla.it>

